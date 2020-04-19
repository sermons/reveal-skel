module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    connect:
      serve:
        options:
          port: 9000
          hostname: 'localhost'
          base: 'dist'

    sass:
      options:
        implementation: require('node-sass')
        includePaths: ['node_modules/reveal.js/css/theme/']
        outputStyle: 'compressed'
      theme:
        files:
          'dist/css/boldblack.css': 'scss/boldblack.scss'

    exec:
      print: 'decktape -s 1024x768 reveal "http://localhost:9000/" print.pdf --no-sandbox; true'
      thumbnail: 'decktape -s 800x600 --screenshots --screenshots-directory . --slides 1 reveal "http://localhost:9000/#/title" dist/img/<%= pkg.shortname %>.jpg --no-sandbox; true'
      reducePDF: 'gs -q -dNOPAUSE -dBATCH -dSAFER -dPDFSETTINGS=/ebook -sDEVICE=pdfwrite -sOutputFile=dist/<%= pkg.shortname %>.pdf print.pdf'
      qr: 'echo https://<%= pkg.config.pretty_url %> | qrcode -o dist/img/<%= pkg.shortname %>-qr.png'

    copy:
      index:
        src: 'index.html'
        dest: 'dist/index.html'
        options:
          process: (content, path) ->
            return grunt.template.process content
      plugin:
        expand: true
        flatten: true
        src: 'node_modules/reveal.js/plugin/notes/*'
        dest: 'dist/js/'
      static:
        expand: true
        src: [
          'img/**',
          'css/**'
        ]
        dest: 'dist/'
      favicon:
        expand: true
        flatten: true
        src: 'img/favicon.*'
        dest: 'dist/'

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

  # Autoload tasks from grunt plugins
  require('load-grunt-tasks')(grunt)

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
      'copy:static'
      'sass:theme'
    ]

  grunt.registerTask 'test',
    '*Render* to PDF', [
      'connect:serve'
      'exec:print'
      'exec:reducePDF'
      'exec:thumbnail'
      'exec:qr'
      'cname'
      'nojekyll'
    ]

  # Define default task.
  grunt.registerTask 'default', [
    'test'
  ]

