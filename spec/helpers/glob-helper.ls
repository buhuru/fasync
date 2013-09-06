# Create alias for jasmine `it` function for use it in LiveScripts
its = (desc, func) ->
  return jasmine.getEnv().it(desc, func);

log = console.log

beforeEach ->
    @addMatchers toBeFunction : ->
        'Function' is typeof! @actual

if module?.exports then
    exports.its = its
