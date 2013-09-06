module.exports = (grunt)->

    grunt.loadNpmTasks 'grunt-livescript'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-jasmine-node'

    grunt.initConfig 
        livescript: dist : files : [
            expand: true     
            cwd: './'      
            src: ['src/**/*.ls', 'spec/**/*.ls']
            dest: 'build'
            ext: '.js'
        ]
        clean : ['./build']
        jasmine_node:
            specNameMatcher: "spec"
            projectRoot: "./build"
            useHelpers: true     
            jUnit: 
              report: true
              savePath : "./build/reports/"
              useDotNotation: true
              consolidate: true
    
        
    grunt.registerTask 'default', ['clean','livescript']
    grunt.registerTask 'test', ['clean','livescript', 'jasmine_node']