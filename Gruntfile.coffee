# Generated on 2016-07-11 using generator-reveal 0.5.9
module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/{,*/}*.{md,html}'
                    'static/**'
                ]

            index:
                files: [
                    'templates/_index.html'
                    'templates/_section.html'
                    'slides/list.json'
                ]
                tasks: ['buildIndex']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

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

        bower:
            dev:
                dest: 'lib/'
                options:
                    packageSpecific:
                        'headjs':
                            files: [ 'dist/1.0.0/head.min.js' ]
                            keepExpandedHierarchy: false
                            js_dest: 'lib/js/'
                        'highlightjs':
                            files: [ 'highlight.pack.js', 'styles/*.css' ]
                            keepExpandedHierarchy: false
                            js_dest: 'lib/js/'
                            css_dest: 'lib/css/hljs/'
                        'reveal.js':
                            files: [ 'js/*.js', 'css/{,*/}*.css', 'plugin/**' ]

        exec:
            print: 'phantomjs rasterise.js "http://localhost:9000/?print-pdf" static/<%= pkg.name.replace(new RegExp(".*\/"), "") %>.pdf'
            thumbnail: 'convert -resize 50% static/<%= pkg.name.replace(/.*\//, "") %>.pdf[0] static/img/thumbnail.jpg'

        copy:
            dist:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                        'lib/**'
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

    grunt.loadNpmTasks 'grunt-bower'

    grunt.registerTask 'buildIndex',
        'Build index.html from templates/_index.html and slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            sectionTemplate = grunt.file.read 'templates/_section.html'
            slides = grunt.file.readJSON 'slides/list.json'

            html = grunt.template.process indexTemplate, data:
                pkg:
                    grunt.config 'pkg'
                slides:
                    slides
                section: (slide) ->
                    grunt.template.process sectionTemplate, data:
                        slide:
                            slide
            grunt.file.write 'index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'serve',
        'Run presentation locally and start watch process (living document).', [
            'buildIndex'
            'bower'
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'pdf',
        'Render a PDF copy of the presentation (using PhantomJS)', [
            'buildIndex'
            'bower'
            'connect:livereload'
            'exec:print'
            'exec:thumbnail'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'pdf'
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
