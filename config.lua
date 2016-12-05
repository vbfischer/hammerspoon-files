local lib = require 'lib'

local cfg = {}
cfg.global = {}

local ufile = require('utils.file')

--------------------
--  global paths  --
--------------------
cfg.global.paths = {}
cfg.global.paths.base  = os.getenv('HOME')
cfg.global.paths.tmp   = os.getenv('TMPDIR')
cfg.global.paths.bin   = lib.toPath(cfg.global.paths.base, 'bin')
cfg.global.paths.cloud = lib.toPath(cfg.global.paths.base, 'Dropbox')
cfg.global.paths.hs    = lib.toPath(cfg.global.paths.base, '.hammerspoon')
cfg.global.paths.data  = lib.toPath(cfg.global.paths.hs,   'data')
cfg.global.paths.media = lib.toPath(cfg.global.paths.hs,   'media')
cfg.global.paths.ul    = '/usr/local'
cfg.global.paths.ulbin = lib.toPath(cfg.global.paths.ul,   'bin')

cfg.global.auto_reload = true

cfg.reload = {
  auto_reload = true
}

cfg.grid = {
  grid_geometries = { { "4x4" }}
}

---------------
--  weather  --
---------------
cfg.weather = {
  menupriority = 1400,            -- menubar priority (lower is lefter)
  fetchTimeout = 120,             -- timeout for downloading weather data
  locationTimeout = 300,          -- timeout for lat/long lookup
  minPrecipProbability = 0.249,   -- minimum to show precipitation details

  api = {  -- forecast.io API config
    key = '9b74afcc35278320b9437faad0e99604',
    maxCalls = 950,  -- forecast.io only allows 1,000 per day
  },

  geoapi = {
    key = 'AIzaSyDSeC0rHGuYn5Hgv0_7f9eyH_a9U614-yY',
    maxCalls = 2500,  -- google geolocation api max is 2,500 per day
  },

  file     = ufile.toPath(cfg.global.paths.data,  'weather.json'),
  iconPath = ufile.toPath(cfg.global.paths.media, 'weather'),
  tempThresholds = {  -- Used for float comparisons, so +0.5 is easier
    warm        = 79.5,
    hot         = 87.5,
    tooHot      = 94.5,
    tooDamnHot  = 99.5,
    alert       = 104.5,
  },
  -- hs.styledtext styles
  styles = {
    default = {
      font  = MONOFONT,
      size  = 13,
    },
    warm = {
      font  = MONOFONT,
      size  = 13,
      color = {red=1,     green=0.96,  blue=0.737, alpha=1},
    },
    hot = {
      font  = MONOFONT,
      size  = 13,
      color = {red=1,     green=0.809, blue=0.493, alpha=1},
    },
    tooHot = {
      font  = MONOFONT,
      size  = 13,
      color = {red=0.984, green=0.612, blue=0.311, alpha=1},
    },
    tooDamnHot = {
      font  = MONOFONT,
      size  = 13,
      color = {red=0.976, green=0.249, blue=0.243, alpha=1},
    },
    alert = {
      font  = MONOFONT,
      size  = 13,
      color = {red=0.94,  green=0.087, blue=0.319, alpha=1},
    },
  }  
}

------------------
--  cheatsheet  --
------------------
cfg.cheatsheet = {
  defaultName = 'default',
  chooserWidth = 50,
  maxParts = 3,
  path = {
    dir    = ufile.toPath(cfg.global.paths.cloud, 'cheatsheets'),
    css    = ufile.toPath(cfg.global.paths.media, 'cheatsheet.min.css'),
    pandoc = ufile.toPath(cfg.global.paths.ulbin, 'pandoc'),
  },
}

return cfg
