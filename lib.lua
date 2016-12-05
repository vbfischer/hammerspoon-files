local lib = {}

function lib.loadModuleByName(modName)
  hsm[modName] = require('modules.' .. modName)
  hsm[modName].name = modName
  hsm[modName].log = hs.logger.new(modName, hsm.cfg.LOGLEVEL)

  hsm.log.i(hsm[modName].name .. ': module loaded')
end

function lib.startModule(mod)
  if mod.start == null then return end
  mod.start()

  hsm.log.i(mod.name .. ': module started')
end


function lib.stopModule(mod)
  if mod.stop == null then return end

  mod.stop()
  hsm.log.i(mod.name .. ': moduled stopped')
end


function lib.toPath(...) return table.concat({...}, '/') end

return lib
