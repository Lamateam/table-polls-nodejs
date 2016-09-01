# Grunt configuration updated to latest Grunt.  That means your minimum
# version necessary to run these tasks is Grunt 0.4.
#
# Please install this locally and install `grunt-cli` globally to run.
module.exports = (grunt) ->
  
  # Initialize the configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    shell:
      start:
        command: "coffee server.coffee"
    clean: 
      tmp: [ "tmp" ]
      dist: [ "dist" ]
    copy:
      bower: 
        files: [
          { expand: true, cwd: 'bower_components/', src: [ '**/*.*' ], dest: 'dist/bower/' },
          { expand: true, cwd: 'bower_components/font-awesome/fonts', src: [ '**/*.*' ], dest: 'dist/fonts/' }
        ]
      vendor: 
        files: [
          { expand: true, cwd: 'vendor/', src: [ '**/*.*' ], dest: 'dist/' }
        ]
    concat:
      css:
        src: [
          "bower_components/font-awesome/css/font-awesome.css"
          "bower_components/bootstrap/dist/css/bootstrap.css"
          "bower_components/gentelella/build/css/custom.css"
          "bower_components/sweetalert/dist/sweetalert.css"
          "bower_components/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css"
          "tmp/style.css"
        ]
        dest: "dist/css/style.css"
    stylus:
      app:
        options:
          define:
            import_tree: require 'stylus-import-tree'
            font_face: require 'stylus-font-face'
        files:
          "tmp/style.css": "src/app/stylus/style.styl"
    coffee:
      app:
        expand: true
        cwd: 'src/app/coffee'
        src: [ '**/*.coffee' ]
        dest: 'dist/js'
        ext: '.js'    
        extDot: 'last'

  # Load external Grunt task plugins.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-mkdir'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-regex-replace'

  # Default task.
  grunt.registerTask "default", [ "clean", "copy", "coffee", "stylus", "concat:css" ]