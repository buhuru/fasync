module.exports = (grunt)->

    grunt.loadNpmTasks 'grunt-livescript'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'

    grunt.initConfig 
        livescript: dist : files : [
            expand: true     
            cwd: './'      
            src: ['src/**/*.ls', 'spec/**/*.ls']
            dest: 'build'
            ext: '.js'
        ]
        clean : ['./build']
        jasmine: test: options: 
            specs: 'build/spec/*-spec.js'
            helpers: 'build/spec/*-helper.js'
        
    grunt.registerTask 'default', ['clean','livescript']
    grunt.registerTask 'test', ['clean','livescript', 'jasmine']