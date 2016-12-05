local mod = {}

mod.config={

}

local k = nil

pressedF18 = function()
  k:enter()
end

releasedF18 = function()
  k:exit()
end

efun = function()
  hs.notify.show("Fun", "Fun", "Here comes the fun...")
end



function mod.init()
  hs.notify.show("Title", "hyperkey", "starting hyperkey")

  k = hs.hotkey.modal.new({}, "F17")
  f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
end

return mod
