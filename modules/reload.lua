local rc = {}
local lib = require 'lib'
local configFileWatcher = nil

function reload()
  hs.fnutils.each(hsm, lib.stopModule)
  hs.reload()
end

function rc.stop()
  rc.log.i("shutting down auto reload watcher...")
  configFileWatcher:stop()
end

function rc.start()
  if rc.cfg.auto_reload then
    rc.log.i("Setting up config auto-reload watcher on %s", hsm.cfg.paths.hs)
    configFileWatcher = hs.pathwatcher.new(hsm.cfg.paths.hs, reload)
    configFileWatcher:start()
  end
end

return rc
