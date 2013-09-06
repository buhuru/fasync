{defer, pipe} = require '../src/fasync'

describe 'fasync.pipe', ->

    beforeEach ->
        @pass-step = (testdata, callback)-> callback null, testdata
        @error-step = (callback)-> callback 'error'
        @spy = jasmine.createSpy 'done'
        @callback = jasmine.createSpy 'callback'
         
    its 'should call finish function if all step`s callbacks passed `null` as first arg', ->
        defered-step1 = defer @pass-step, 'data1'
        defered-step2 = defer @pass-step, 'data2'
        pipe defered-step1, defered-step2, @spy
        expect @spy .toHaveBeenCalledWith null, 'data1', 'data2'

    
    