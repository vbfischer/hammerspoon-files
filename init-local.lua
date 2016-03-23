-- Uncomment to set non-default log level
logger.setLogLevel('debug')

omh_config("plugins.windows.grid", {
    grid_key = {{"Ctrl", "Alt", "Cmd", "Shift"}, "g"}
  });

omh_config("plugins.misc.url_handling",
           {
              patterns = {
               { "https?://localhost:8080", "com.google.Chrome"}
              }
           });


local watcher = hs.screen.watcher.new(function() hs.notify.show('changed') end)
watcher:start()
