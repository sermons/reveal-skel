module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    connect:
      serve:
        options:
          port: 9000
          hostname: 'localhost'

    coffeelint:
      options:
        indentation:
          value: 2
        max_line_length:
          level: 'ignore'
      all: ['Gruntfile.coffee']

    curl:
      qr:
        src: 'https://zxing.org/w/chart?cht=qr&chs=350x350&chld=M&choe=UTF-8&chl=https%3A%2F%2F<%= pkg.config.pretty_url %>'
        dest: 'static/img/<%= pkg.shortname %>-qr.png'
      phantom:
        src: 'https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64'
        dest: 'phantomjs'

    exec:
      print: 'chmod +x phantomjs; ./phantomjs decktape/decktape.js -s 1024x768 --load-pause=10000 reveal "http://localhost:9000/" static/<%= pkg.shortname %>.pdf'
      print_hd: 'chmod +x phantomjs; ./phantomjs decktape/decktape.js -s 1920x1080 --load-pause=10000 reveal "http://localhost:9000/" static/<%= pkg.shortname %>_hd.pdf'
      thumbnail: 'convert -resize 50% static/<%= pkg.shortname %>.pdf[0] static/img/thumbnail.jpg'

    copy:
      index:
        src: '_index.html'
        dest: 'index.html'
        options:
          process: (content, path) ->
            return grunt.template.process content
      dist:
        files: [{
          expand: true
          src: [
            'static/**'
            'index.html'
            'CNAME'
            '.nojekyll'
          ]
          dest: 'dist/'
        },{
          src: 'static/img/favicon.ico'
          dest: 'dist/'
        }]

    buildcontrol:
      options:
        dir: 'dist'
        commit: true
        push: true
        fetchProgress: false
        config:
          'user.name': '<%= pkg.config.git.name %>'
          'user.email': '<%= pkg.config.git.email %>'
      github:
        options:
          remote: 'git@github.com:<%= pkg.repository %>'
          branch: 'gh-pages'

    gitclone:
      decktape:
        options:
          repository: 'https://github.com/astefanutti/decktape'
          depth: 1

  # Generated grunt vars
  grunt.config.merge
    pkg:
      shortname: '<%= pkg.name.replace(new RegExp(".*\/"), "") %>'
      commit: (process.env.TRAVIS_COMMIT || "testing").substr(0,7)

  # Load all grunt tasks.
  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks('grunt-git')

  grunt.registerTask 'serve',
    'Run presentation locally', [
      'copy:index'
      'connect:serve'
    ]

  grunt.registerTask 'cname',
    'Create CNAME from NPM config if needed.', ->
      if grunt.config 'pkg.config.cname'
        grunt.file.write 'CNAME', grunt.config 'pkg.config.cname'

  grunt.registerTask 'nojekyll',
    'Create .nojekyll file for Github Pages', ->
      grunt.file.write '.nojekyll', ''

  grunt.registerTask 'pdf',
    'Render a PDF copy of the presentation (using PhantomJS)', [
      'serve'
      'gitclone:decktape'
      'curl:phantom'
      'exec:print'
      'exec:thumbnail'
    ]

  grunt.registerTask 'test',
    '*Test* rendering to PDF', [
      'coffeelint'
      'pdf'
    ]

  grunt.registerTask 'dist',
    'Save presentation files to *dist* directory.', [
      'curl:qr'
      'cname'
      'nojekyll'
      'copy:dist'
    ]

  grunt.registerTask 'deploy',
    'Deploy to Github Pages', [
      'dist'
      'buildcontrol:github'
    ]

  # Define default task.
  grunt.registerTask 'default', [
    'test'
  ]

