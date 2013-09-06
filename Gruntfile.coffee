module.exports = (grunt)->

    grunt.loadNpmTasks 'grunt-livescript'
    grunt.loadNpmTasks 'grunt-contrib-clean'
        
    grunt.initConfig 
        livescript: dist : files : [
            expand: true     
            cwd: './'      
            src: ['src/**/*.ls', 'spec/**/*.ls']
            dest: 'build'
            ext: '.js'
        ]
        clean : ['./build']
        
    grunt.registerTask 'default', ['clean','livescript']
    grunt.registerTask 'test', ['clean','livescript', 'jasmine']