-- Uncomment to set non-default log level
logger.setLogLevel('debug')

logger.i('in init-local')

omh_config("plugins.windows.grid", {
    grid_key = {{"Ctrl", "Alt", "Cmd", "Shift"}, "g"},
  });

omh_config("plugins.mouse.locator", {
})

omh_config("plugins.misc.url_handling",
           {
              patterns = {
               { "https?://localhost:8080", "com.google.Chrome"}
              }
           });
