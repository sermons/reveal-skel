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

    exec:
      print: 'decktape -s 1024x768 reveal "http://localhost:9000/" static/<%= pkg.shortname %>.pdf; true'
      thumbnail: 'decktape -s 1024x768 --screenshots --screenshots-directory . --slides 1 reveal "http://localhost:9000/" static/img/thumbnail.jpg; true'
      inline: 'inliner http://localhost:9000/ > inline.html'

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
            'inline.html'
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

  # Generated grunt vars
  grunt.config.merge
    pkg:
      shortname: grunt.config('pkg.name').replace(/.*\//, '')
      commit: (process.env.TRAVIS_COMMIT || "testing").substr(0,7)
    img: (id) ->
      'https://sermons.seanho.com/img/' + id
    bg: (id) ->
      'data-background-image="' + grunt.config('img')("bg/" + id) + '"'
    bible: (ref, text=ref, ver='NIV') ->
      '[' + text + '](' +
      'https://mobile.biblegateway.com/passage/?search=' +
      ref.replace(/[^\w.:,-]+/g, '') + '&version=' + ver + ' "ref")'

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

  grunt.registerTask 'install',
    '*Install* dependencies', [
    ]

  grunt.registerTask 'pdf',
    'Render a **PDF** copy of the presentation (using decktape)', [
      'serve'
      'exec:print'
      'exec:thumbnail'
    ]

  grunt.registerTask 'test',
    '*Test* rendering to PDF', [
      'coffeelint'
      'pdf'
      'exec:inline'
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

