module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    config:
      shortname: '<%= pkg.name.replace(new RegExp(".*\/"), "") %>'

    watch:
      index:
        files: ['_index.html']
        tasks: ['buildIndex']
      coffeelint:
        files: ['Gruntfile.coffee']
        tasks: ['coffeelint']

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
        src: 'https://zxing.org/w/chart?cht=qr&chs=350x350&chld=M&choe=UTF-8&chl=<%= pkg.config.pretty_url %>'
        dest: 'static/img/<%= config.shortname %>-qr.png'

    exec:
      print: 'phantomjs --debug=true rasterise.js "http://localhost:9000/?print-pdf" static/<%= config.shortname %>.pdf 999 728'
      thumbnail: 'convert -resize 50% static/<%= config.shortname %>.pdf[0] static/img/thumbnail.jpg'

    copy:
      dist:
        files: [{
          expand: true
          src: [
            'slides/**'
            'static/**'
          ]
          dest: 'dist/'
        },{
          src: [
            'index.html'
            'CNAME'
            '.nojekyll'
          ]
          dest: 'dist/'
          filter: 'isFile'
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

  # Load all grunt tasks.
  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'buildIndex',
    'Build index.html from template.', ->
      indexTemplate = grunt.file.read '_index.html'
      html = grunt.template.process indexTemplate, data:
        pkg: grunt.config 'pkg'
        config: grunt.config 'config'
      grunt.file.write 'index.html', html

  grunt.registerTask 'cname',
    'Create CNAME from NPM config if needed.', ->
      if grunt.config 'pkg.config.cname'
        grunt.file.write 'CNAME', grunt.config 'pkg.config.cname'

  grunt.registerTask 'nojekyll',
    'Create .nojekyll file for Github Pages', ->
      grunt.file.write '.nojekyll', ''

  grunt.registerTask 'test',
    '*Test* rendering: lint Coffeescripts.', [
      'coffeelint'
    ]

  grunt.registerTask 'serve',
    'Run presentation locally', [
      'buildIndex'
      'connect'
    ]

  grunt.registerTask 'pdf',
    'Render a PDF copy of the presentation (using PhantomJS)', [
      'buildIndex'
      'connect:serve'
      'exec:print'
      'exec:thumbnail'
    ]

  grunt.registerTask 'dist',
    'Save presentation files to *dist* directory.', [
      'pdf'
      'curl:qr'
      'cname'
      'nojekyll'
      'copy'
    ]

  grunt.registerTask 'deploy',
    'Deploy to Github Pages', [
      'dist'
      'buildcontrol'
    ]

  # Define default task.
  grunt.registerTask 'default', [
    'test'
    'serve'
  ]

