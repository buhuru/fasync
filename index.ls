{ List: {head, last, each, tail}} = require 'prelude-ls'
log = console.log


apply = (foo=->, args=[])->
    foo.apply foo, args

lapply = (foo=->, ...largs)->
    (...rargs)->  apply foo, largs ++ rargs

fiterator = (is-fallback = false, ...foopipe, finish=->) -> 
    return false if foopipe.length is 0
    fallback = [null]

    cursor = (pipe) ->
        foo = head pipe
        return finish 'type error' if typeof foo is not 'function'
        foo = lapply foo, last fallback if is-fallback
        (err=null, res=null) <- foo
        return finish err if err
        fallback.push res
        pipe.shift!
        if pipe.length is 0 then
            apply finish, [err] ++ tail fallback 
        else
            cursor pipe
    cursor foopipe

waterfall = lapply fiterator, true
pipe = lapply fiterator, false


parallel = (...foopipe, finish=->)->
    fallback = []
    cursor = (foo) ->
        return finish 'type error' if typeof foo is not 'function'
        (err=null, res=null) <- foo
        fallback.push [err, res]
        apply finish, fallback if foopipe.length is fallback.length

    each cursor, foopipe

defer = (foo) ->
    throw 'type error: defer' if typeof foo is not 'function'
    (...args, next=null)->
        if typeof next is not 'function' then
            throw 'type error: deferred function extect callback to be last argument' 

        if not next and typeof last args is 'function' then
            foo.call foo, last args
        apply foo, args ++ [next]
        

if module and module.exports then module.exports = {
    _fiterator : fiterator
    _lapply : lapply
    defer : defer
    waterfall : waterfall
    pipe : pipe
    parallel : parallel
}