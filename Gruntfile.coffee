module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    copy:
      static:
        expand: true
        dot: true
        cwd: 'static'
        src: '**'
        dest: 'dist/'
      template:
        expand: true
        cwd: 'template'
        src: '**'
        dest: 'dist/'
        options:
          process: (content, path) ->
            return grunt.template.process content
      plugin:
        expand: true
        flatten: true
        src: 'node_modules/socket.io-client/dist/*'
        dest: 'dist/lib/socket.io/'

    sass:
      options:
        implementation: require('sass')
        loadPaths: ['node_modules/reveal.js/css/theme/']
        outputStyle: 'compressed'
      theme:
        files: [{
          expand: true
          cwd: 'scss'
          src: '*.scss'
          dest: 'dist/css/'
          ext: '.css'
        }]

    connect:
      serve:
        options:
          port: 9000
          hostname: 'localhost'
          base: 'dist'

    exec:
      print: 'decktape -s 1024x768 --screenshots --screenshots-size 1920x1080 --screenshots-format jpg --screenshots-directory dist/img --chrome-arg=--no-sandbox reveal "http://localhost:9000/?s=none" print.pdf'
      reducePDF: 'gs -q -dNOPAUSE -dBATCH -dSAFER -dPDFSETTINGS=/ebook -sDEVICE=pdfwrite -sOutputFile=dist/<%= pkg.shortname %>.pdf print.pdf'
      thumbnail: "convert -geometry '330x330>' dist/img/print_1_* dist/img/<%= pkg.shortname %>.png"
      qr: 'echo https://<%= pkg.config.pretty_url %> | qrcode -o dist/img/<%= pkg.shortname %>-qr.png'

  # Macros for convenience
  grunt.config.merge
    pkg:
      shortname: grunt.config('pkg.name').replace(/.*\//, '')
      commit: (process.env.GITHUB_SHA || "testing").substr(0,7)
      config:
        pretty_url: grunt.config('pkg.config.cname') unless grunt.config('pkg.config.pretty_url')
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

  grunt.registerTask 'install',
    '*Build* site', [
      'copy:static'
      'copy:template'
      'copy:plugin'
      'sass:theme'
    ]

  grunt.registerTask 'test',
    '*Render* to PDF', [
      'connect:serve'
      'exec:print'
      'exec:reducePDF'
      'exec:thumbnail'
      'exec:qr'
    ]

  # Define default task.
  grunt.registerTask 'default', [
    'test'
  ]

