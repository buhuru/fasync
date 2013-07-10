fasync
======


How to use:
'''
//defer guaranties that your async steps will get their callback as last argument
foo1 = defer (...args, next)->
    next null, 'foo1data'

foo2 = defer (...args, next)->
    next null, 'foo1data'

// this async step that will break flow
fooError = defer (...args, next)->
    next 'this is error'

// every next async step began only when previous fires callback
// if any error returned, flow will break and pass err to finish callback
// if no errors all data wuill be passed as non error arguments to finish callbeck
pipe foo1, foo2, (err, foo1data, foo2data) ->
    log 'finish', arguments

// same as pipe exept
// ...args of every 'foo' async step will contain data returned by previuos callback or null
waterfall foo1, foo2, (err, foo1data, foo2data) ->
    log 'finish', arguments

// all async steps fires independently and finish callback waits their results inducing errors
parallel foo1, foo2, (arrErr, foo1data, foo2data) ->
    log 'finish', arguments
'''