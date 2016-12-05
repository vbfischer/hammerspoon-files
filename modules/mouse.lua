local mod={}

mod.cfg = {
  color = {red=1,blue=0,green=0,alpha=1},
  linewidth = 5,
  diameter = 80
}

local mouseCircle = nil
local mouseCircleTimer = nil

function mod.highlightMouse()
  
  -- Delete an existing highlight if it exists
  if mouseCircle then
      mouseCircle:delete()
      if mouseCircleTimer then
          mouseCircleTimer:stop()
      end
  end
  -- Get the current co-ordinates of the mouse pointer
  mousepoint = hs.mouse.getAbsolutePosition ()
  -- Prepare a big red circle around the mouse pointer
  local diameter = mod.cfg.diameter
  local radius = math.floor(diameter / 2)
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-radius, mousepoint.y-radius, diameter, diameter))
  mouseCircle:setStrokeColor(mod.cfg.color)
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(mod.cfg.linewidth)
  mouseCircle:show()

  -- Set a timer to delete the circle after 3 seconds
  mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

return mod;
