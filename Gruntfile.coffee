module.exports = (grunt) ->
    
    grunt.initConfig
        compass:
            dist:
                options:
                    sassDir: 'src/sass'
                    cssDir: 'dist/styles'
                    clean: true
            watch:
                options:
                    sassDir: 'src/sass'
                    cssDir: 'dist/styles'
                    watch: true
        bower:
            install:
                options:
                    targetDir: 'dist/components'
                    install: true
        concurrent:
            server:
                tasks: ['compass:watch', 'nodemon']
                options:
                    logConcurrentOutput: true
        nodemon:
            server:
                options:
                    file: 'src/server.js'
                    env:
                        PORT: '3000'
        clean:
            npm: "node_modules"

    grunt.registerTask 'default', ['bower:install','concurrent:server']
    grunt.registerTask 'travis', ['bower:install','compass:dist']

    for key, value of require('./package.json').devDependencies
        if (key.indexOf('grunt-') == 0)
            grunt.loadNpmTasks key