{defer} = require '../src/fasync'
describe 'fasync.defer', ->

    beforeEach ->
        @spy = jasmine.createSpy!
        @noop = ->

    its 'should throw exeprtion if defered function wasn`t passed as first arg', ->
        expect defer .toThrowError!

    its 'defered should throw an exeption if no callbacks passed as last arg', ->
        defered = defer @spy
        call-defered = -> defered @noop , 1, 2
        expect call-defered .toThrowError!

    its 'should return function', ->
        expect defer @noop  .toBeFunction!

    its 'should carry on left args', ->
        defered = defer @spy, 'first arg'
        defered 'second arg', @noop
        expect @spy .toHaveBeenCalledWith 'first arg','second arg', @noop
    