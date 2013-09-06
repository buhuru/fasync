{defer} = require '../src/fasync'
describe 'defer', ->
    its 'should be function', ->
        expect(defer).toBeFunction()