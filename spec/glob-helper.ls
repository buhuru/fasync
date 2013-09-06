# Create alias for jasmine `it` function for use it in LiveScripts
its = (desc, func) ->
  return jasmine.getEnv().it(desc, func);

if module?.exports then
    exports.its = its
if window then
    window.its = its