local mod = {}

local frameCache = {}
local grid = require "hs.grid"

mod.cfg = {
  grid_geometries = { { "4x4"} }
}

local function snapToBottom(win, cell, screen)
    local newCell =
        hs.geometry(cell.x, grid.GRIDHEIGHT - cell.h, cell.w, cell.h)
    hs.grid.set(win, newCell, screen)
end

local function snapToTop(win, cell, screen)
    local newCell =
        hs.geometry(cell.x, 0, cell.w, cell.h)
    hs.grid.set(win, newCell, screen)
end

local function snapToLeft(win, cell, screen)
    local newCell =
        hs.geometry(0, cell.y, cell.w, cell.h)
    hs.grid.set(win, newCell, screen)
end

local function snapToRight(win, cell, screen)
    local newCell =
        hs.geometry(grid.GRIDWIDTH - cell.w, cell.y, cell.w, cell.h)
    hs.grid.set(win, newCell, screen)
end

local function compensateMargins()
    -- Compensate for the double margin between windows
    local win = hs.window.focusedWindow()
    local cell = grid.get(win)
    local frame = win:frame()
    if cell.h < grid.GRIDHEIGHT and cell.h % 1 == 0 then
        if cell.y ~= 0 then
            frame.h = frame.h + grid.MARGINY / 2
            frame.y = frame.y - grid.MARGINY / 2
            win:setFrame(frame)
        end
        if cell.y + cell.h ~= grid.GRIDHEIGHT then
            frame.h = frame.h + grid.MARGINX / 2
            win:setFrame(frame)
        end
    end
    if cell.w < grid.GRIDWIDTH and cell.w % 1 == 0 then
        if cell.x ~= 0 then
            frame.w = frame.w + grid.MARGINY / 2
            frame.x = frame.x - grid.MARGINY / 2
            win:setFrame(frame)
        end
        if cell.x + cell.w ~= grid.GRIDWIDTH then
            frame.w = frame.w + grid.MARGINY / 2
            win:setFrame(frame)
        end
    end
end


local function resizeFinderW(cell)
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        -- local cell = grid.get(app:focusedWindow())
        if cell.w == 2 and not growing then
            app:selectMenuItem({"Visualizar", "Ocultar Barra Lateral"})
            -- app:selectMenuItem({"View", "Hide Sidebar"}) -- In english
        else
            app:selectMenuItem({"Visualizar", "Mostrar Barra Lateral"})
            -- app:selectMenuItem({"View", "Show Sidebar"}) -- In english
        end
    end
end

local function resizeFinderH(cell)
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        -- local cell = grid.get(app:focusedWindow())
        if cell.h == 2 and not growing then
            app:selectMenuItem({"Visualizar", "Ocultar Barra de Ferramentas"})
            -- app:selectMenuItem({"View", "Hide Toolbar"})
            app:selectMenuItem({"Visualizar", "Ocultar Barra de Estado"})
            -- app:selectMenuItem({"View", "Hide Status Bar"})
        else
            app:selectMenuItem({"Visualizar", "Mostrar Barra de Ferramentas"})
            -- app:selectMenuItem({"View", "Show Status Bar"})
            app:selectMenuItem({"Visualizar", "Mostrar Barra de Estado"})
            -- app:selectMenuItem({"View", "Show Status Bar"})
        end
    end
end

function mod.topHalf()
end

function mod.toggleMaximized()
  local win = hs.window.focusedWindow()
  if(win == nil) or (win:id() == nil) then
    return
  end

  if frameCache[win:id()] then
    win:setFrame(frameCache[win:id()])
    frameCache[win:id()] = nil
  else
    frameCache[win:id()] = win:frame()
    win:maximize()
  end
end

function mod.pushWindowUp()
  grid.pushWindowUp()
end

function mod.pushWindowDown()
  grid.pushWindowDown()
end

function mod.pushWindowLeft()
  grid.pushWindowLeft()
end

function mod.pushWindowRight()
  grid.pushWindowRight()
end

function mod.toggleShow()
    hs.grid.toggleShow()
end

function mod.growShrinkWindowTop()
  local win = hs.window.focusedWindow()
  local cell = grid.get(win)
  local screen = win:screen()

  if cell.y > 0 then
    snapToTop(win, cell, screen)
    compensateMargins()
    return
  end

  if cell.h <= 1 then
    growing = true
  elseif cell.h >= grid.GRIDHEIGHT then
    growing = false
  end
  resizeFinderH(cell)
  if growing then
    grid.resizeWindowTaller()
  else
    grid.resizeWindowShorter()
  end

  local cell = grid.get(win)
  snapToTop(win, cell, screen)
  compensateMargins()
end

function mod.growShrinkWindowBottom()
  local win = hs.window.focusedWindow()
  local cell = grid.get(win)
  local screen = win:screen()
  if cell.y < grid.GRIDHEIGHT - cell.h then
      snapToBottom(win, cell, screen)
      compensateMargins()
      return
  end
  if cell.h <= 1 then
      growing = true
  elseif cell.h >= grid.GRIDHEIGHT then
      growing = false
  end
  resizeFinderH(cell)
  if growing then
      grid.resizeWindowTaller()
  else
      grid.resizeWindowShorter()
  end
  local cell = grid.get(win)
  snapToBottom(win, cell, screen)
  compensateMargins()
end

function mod.growShrinkWindowLeft()
  local win = hs.window.focusedWindow()
  local cell = grid.get(win)
  local screen = win:screen()
  if cell.x > 0 then
      snapToLeft(win, cell, screen)
      compensateMargins()
      return
  end
  if cell.w <= 1 then
      growing = true
  elseif cell.w >= grid.GRIDWIDTH then
      growing = false
  end
  resizeFinderW(cell)
  if growing then
      grid.resizeWindowWider()
  else
      grid.resizeWindowThinner()
  end
  local cell = grid.get(win)
  snapToLeft(win, cell, screen)
  compensateMargins()
end

function mod.growShrinkWindowRight()
  local win = hs.window.focusedWindow()
  local cell = grid.get(win)
  local screen = win:screen()
  if cell.x < grid.GRIDWIDTH - cell.w then
      snapToRight(win, cell, screen)
      compensateMargins()
      return
  end
  if cell.w <= 1 then
      growing = true
  elseif cell.w >= grid.GRIDWIDTH then
      growing = false
  end
  resizeFinderW(cell)
  if growing then
      grid.resizeWindowWider()
  else
      grid.resizeWindowThinner()
  end
  local cell = grid.get(win)
  snapToRight(win, cell, screen)
  compensateMargins()
end

function mod.start()
  for i,v in ipairs(mod.cfg.grid_geometries) do
    hs.grid.setGrid(v[1], v[2])
  end
end

return mod
