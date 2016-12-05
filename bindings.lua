local bindings = {}
local k = nil

pressedF18 = function()
  k.triggered = false
  k:enter()
end

releasedF18 = function()
  k:exit()

  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

doBinding = function(modal, key, fn)
  modal:bind({}, key, nil, function()
    fn()
    modal.triggered = true
  end)
end

function bindings.bind()
   k = hs.hotkey.modal.new({}, "F17")
   local f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

   hs.fnutils.each({
     {modal = k, key='d', fn = hsm.mouse.highlightMouse},
     {modal = k, key='t', fn = hsm.grid.toggleShow},
     {modal = k, key='c', fn = hs.toggleConsole},
     {modal = k, key='f', fn = hsm.grid.toggleMaximized},

     {modal = k, key='Up', fn = hsm.grid.pushWindowUp},
     {modal = k, key='Down', fn = hsm.grid.pushWindowDown},
     {modal = k, key='Left', fn = hsm.grid.pushWindowLeft},
     {modal = k, key='Right', fn = hsm.grid.pushWindowRight},
     {modal = k, key='k', fn = hsm.grid.growShrinkWindowTop},
     {modal = k, key='j', fn = hsm.grid.growShrinkWindowBottom},
     {modal = k, key='h', fn = hsm.grid.growShrinkWindowLeft},
     {modal = k, key='l', fn = hsm.grid.growShrinkWindowRight},
     {modal = k, key='s', fn = hsm.cheatsheet.toggle},
     {modal = k, key = 'x', fn = hsm.cheatsheet.chooserToggle},
   }, function(object)
     doBinding(object.modal, object.key, object.fn)
   end)
end

-- Hyperkey Bindings...
return bindings
