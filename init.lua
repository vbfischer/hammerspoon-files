local LOGLEVEL = 'debug'
local cfg = require 'config'
local lib = require 'lib'

local modules = {
  'mouse',
  'grid',
  'weather',
  'cheatsheet'
}

-- Setup GLOBAL stuff...
hsm = {}
hsm.cfg = cfg.global
hsm.cfg.LOGLEVEL = LOGLEVEL
hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)

-- Load Lib, requires global to be set...


local function configModule(mod)
  mod.cfg = mod.cfg or {}

  if(cfg[mod.name]) then
    for k,v in pairs(cfg[mod.name]) do mod.cfg[k] = v end
    hsm.log.i(mod.name .. ': module configured')
  end
end

hs.fnutils.each(modules, lib.loadModuleByName)
hs.fnutils.each(hsm, configModule)
hs.fnutils.each(hsm, lib.startModule)

-- finally load bindings...
local bindings = require 'bindings'
bindings.bind()

-- Disable all window animations
hs.window.animationDuration = 0.2

hs.alert.show('Hammerspoon Config Loaded', 1)
