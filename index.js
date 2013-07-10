(function(){
  var ref$, head, last, each, tail, log, apply, lapply, fiterator, waterfall, pipe, parallel, defer, slice$ = [].slice;
  ref$ = require('prelude-ls').List, head = ref$.head, last = ref$.last, each = ref$.each, tail = ref$.tail;
  log = console.log;
  apply = function(foo, args){
    foo == null && (foo = function(){});
    args == null && (args = []);
    return foo.apply(foo, args);
  };
  lapply = function(foo){
    var largs;
    foo == null && (foo = function(){});
    largs = slice$.call(arguments, 1);
    return function(){
      var rargs;
      rargs = slice$.call(arguments);
      return apply(foo, largs.concat(rargs));
    };
  };
  fiterator = function(isFallback){
    var i$, foopipe, finish, ref$, fallback, cursor;
    isFallback == null && (isFallback = false);
    foopipe = 1 < (i$ = arguments.length - 1) ? slice$.call(arguments, 1, i$) : (i$ = 1, []), finish = (ref$ = arguments[i$]) != null
      ? ref$
      : function(){};
    if (foopipe.length === 0) {
      return false;
    }
    fallback = [null];
    cursor = function(pipe){
      var foo;
      foo = head(pipe);
      if (typeof foo !== 'function') {
        return finish('type error');
      }
      if (isFallback) {
        foo = lapply(foo, last(fallback));
      }
      return foo(function(err, res){
        err == null && (err = null);
        res == null && (res = null);
        if (err) {
          return finish(err);
        }
        fallback.push(res);
        pipe.shift();
        if (pipe.length === 0) {
          return apply(finish, [err].concat(tail(fallback)));
        } else {
          return cursor(pipe);
        }
      });
    };
    return cursor(foopipe);
  };
  waterfall = lapply(fiterator, true);
  pipe = lapply(fiterator, false);
  parallel = function(){
    var i$, foopipe, finish, ref$, fallback, cursor;
    foopipe = 0 < (i$ = arguments.length - 1) ? slice$.call(arguments, 0, i$) : (i$ = 0, []), finish = (ref$ = arguments[i$]) != null
      ? ref$
      : function(){};
    fallback = [];
    cursor = function(foo){
      if (typeof foo !== 'function') {
        return finish('type error');
      }
      return foo(function(err, res){
        err == null && (err = null);
        res == null && (res = null);
        fallback.push([err, res]);
        if (foopipe.length === fallback.length) {
          return apply(finish, fallback);
        }
      });
    };
    return each(cursor, foopipe);
  };
  defer = function(foo){
    if (typeof foo !== 'function') {
      throw 'type error: defer';
    }
    return function(){
      var i$, args, next, ref$;
      args = 0 < (i$ = arguments.length - 1) ? slice$.call(arguments, 0, i$) : (i$ = 0, []), next = (ref$ = arguments[i$]) != null ? ref$ : null;
      if (typeof next !== 'function') {
        throw 'type error: deferred function extect callback to be last argument';
      }
      if (!next && typeof last(args === 'function')) {
        foo.call(foo, last(args));
      }
      return apply(foo, args.concat([next]));
    };
  };
  if (module && module.exports) {
    module.exports = {
      _fiterator: fiterator,
      _lapply: lapply,
      defer: defer,
      waterfall: waterfall,
      pipe: pipe,
      parallel: parallel
    };
  }
}).call(this);
