module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

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

    sass:
      options:
        includePaths: ['node_modules/reveal.js/css/theme/']
        outputStyle: 'compressed'
      theme:
        files:
          'static/css/boldblack.css': 'scss/boldblack.scss'

    exec:
      print: 'decktape -s 1024x768 reveal "http://localhost:9000/" <%= pkg.pdf %>; true'
      thumbnail: 'decktape -s 800x600 --screenshots --screenshots-directory . --slides 1 reveal "http://localhost:9000/#/title" static/img/thumbnail.jpg; true'
      reducePDF: 'mv <%= pkg.pdf %> print.pdf; gs -q -dNOPAUSE -dBATCH -dSAFER -dPDFA=2 -dPDFSETTINGS=/ebook -sDEVICE=pdfwrite -sOutputFile=<%= pkg.pdf %> print.pdf'
      inline: 'script -qec "inliner -m index.html" /dev/null > <%= pkg.shortname %>.html'
      qr: 'qrcode https://<%= pkg.config.pretty_url %> static/img/<%= pkg.shortname %>-qr.png'

    copy:
      index:
        src: '_index.html'
        dest: 'index.html'
        options:
          process: (content, path) ->
            return grunt.template.process content
      plugin:
        expand: true
        flatten: true
        src: 'node_modules/reveal.js/plugin/notes/*'
        dest: 'static/js/'
      dist:
        files: [{
          expand: true
          src: [
            'static'
            'index.html'
            '<%= pkg.shortname %>.html'
            'service-worker.js'
          ]
          dest: 'dist/'
        },{
          flatten: true
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

    'sw-precache':
      options:
        cacheId: '<%= pkg.name %>'
        maximumFileSizeToCacheInBytes: 10485760
        logger: grunt.log.write
        verbose: true
      main:
        baseDir: ''
        staticFileGlobs: [
          'static/**/*'
        ]
        runtimeCaching: [{
          urlPattern: /./
          handler: 'cacheFirst'
        }]

  # Additional grunt vars and macros
  grunt.config.merge
    pkg:
      shortname: grunt.config('pkg.name').replace(/.*\//, '')
      pdf: 'static/<%= pkg.shortname %>.pdf'
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
  grunt.loadNpmTasks 'grunt-git'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-sw-precache'

  grunt.registerTask 'cname',
    'Create CNAME for Github Pages', ->
      if grunt.config 'pkg.config.cname'
        grunt.file.write 'dist/CNAME', grunt.config 'pkg.config.cname'

  grunt.registerTask 'nojekyll',
    'Disable Jekyll processing on Github Pages', ->
      grunt.file.write 'dist/.nojekyll', ''

  grunt.registerTask 'install',
    '*Compile* templates', [
      'copy:index'
      'copy:plugin'
      'sass:theme'
      'sw-precache:main'
    ]

  grunt.registerTask 'test',
    '*Render* to PDF and inlined HTML', [
      'coffeelint'
      'connect:serve'
      'exec:print'
      'exec:reducePDF'
      'exec:thumbnail'
    ]

  grunt.registerTask 'dist',
    'Save presentation files to *dist* directory.', [
      'exec:qr'
      'copy:dist'
    ]

  grunt.registerTask 'deploy',
    'Deploy to Github Pages', [
      'dist'
      'cname'
      'nojekyll'
      'buildcontrol:github'
    ]

  # Define default task.
  grunt.registerTask 'default', [
    'test'
  ]

