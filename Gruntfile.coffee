module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        config:
            shortname: '<%= pkg.name.replace(new RegExp(".*\/"), "") %>'

        watch:
            index:
                files: [
                    'templates/_index.html'
                ]
                tasks: ['buildIndex']
            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']
            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        connect:
            serve:
                options:
                    port: 9000
                    hostname: 'localhost'

        coffeelint:
            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'ignore'
            all: ['Gruntfile.coffee']

        jshint:
            options:
                jshintrc: '.jshintrc'
            all: ['js/*.js']

        exec:
            print: 'phantomjs rasterise.js "http://localhost:9000/?print-pdf" static/<%= config.shortname %>.pdf'
            printHD: 'phantomjs --debug=true rasterise.js "http://localhost:9000/?print-pdf" static/<%= config.shortname %>-HD.pdf 1920 1080'
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
                    expand: true
                    src: ['index.html', 'CNAME', 'favicon.ico', '.nojekyll']
                    dest: 'dist/'
                    filter: 'isFile'
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
        'Build index.html from templates/_index.html.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            html = grunt.template.process indexTemplate, data:
                pkg: grunt.config 'pkg'
                config: grunt.config 'config'
            grunt.file.write 'index.html', html

    grunt.registerTask 'cname',
        'Create CNAME from NPM config if needed.', ->
            if grunt.config 'pkg.config.cname'
                grunt.file.write 'CNAME', grunt.config 'pkg.config.cname'

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
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
            'exec:printHD'
            'exec:thumbnail'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'pdf'
            'cname'
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
