local notify = require("notify")
notify.setup({
  background_colour = "#000000",
  render = "minimal",
  stages = "slide",
  fps = 60
})

local allowLogging = true

local M = {}

function M.createLoggerMaker(moduleName)
  return function (funcName)
    return {
      log = function (str)
        if allowLogging then
          print('['.. moduleName ..' -> ' .. funcName ..'] ' .. str)
        end
      end
    }
  end
end

function M.moduleLogger(module)
  return {
    forFunc = M.createLoggerMaker(module)
  }
end

function M.getFuncLogger(moduleLogger, funcName, shouldLog)
  local logger = moduleLogger.forFunc(funcName)
  return function (str)
    if shouldLog then
      logger.log(str)
    end
  end
end

local utilsLogger = M.moduleLogger('utils')

function M.base(msg, name, level)
  local prefix = name and name .. ": " or ""
  notify(prefix .. msg, level, { title = name })
end

function M.warn(msg, name)
  M.base(msg, name, "warn")
end

function M.error(msg, name)
  M.base(msg, name, "error")
end

function M.info(msg, name)
  M.base(msg, name, "info")
end

function M.removePathChars(str)
  return str:gsub("/", ""):gsub("~", ""):gsub("-", ""):gsub("%s+", "")
end

function M.getHome()
  local home = vim.fn.expand("~");
  return home
end

function M.getCwd()
  local home = M.getHome()
  local actual_cwd = vim.fn.getcwd()
  local shortened_cwd = M.trim(actual_cwd:gsub(home, "~"))

  return shortened_cwd
end

function M.getCwdShort()
  local cwd = M.getCwd()
  local abbreviated_cwd = M.shortenCommonFolders(cwd)

  return abbreviated_cwd
end

function M.getFileCwd()
  local home = M.getHome()
  local fileCwd = M.trim(vim.fn.expand("%:p:h"):gsub(home, "~"))

  return fileCwd
end

function M.getFileCwdShort()
  local fileCwd = M.getFileCwd()
  local abbreviated_cwd = M.shortenCommonFolders(fileCwd)

  return abbreviated_cwd
end

function M.escapeStringForReplace(text)
  return text:gsub("([^%w])", "%%%1")
end

function M.replace(text, pattern, replace_string, ...)
   return (text:gsub(
      pattern:gsub("%p","%%%0"), 
      replace_string:gsub("%%","%%%%"), 
      ...
   ))
end

function M.match(text, pattern)
  local shouldLog = false
  local log = M.getFuncLogger(utilsLogger, "match", shouldLog)

  pattern = pattern:gsub("%W","%%%0")

  log("received text: " .. text .. " | received pattern: " .. pattern)

  local matched = string.match(text, pattern)

  log("matched? (nil if not): " .. tostring(matched))

  return matched
end

function M.trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function M.shortenCommonFolders(text)
  local commonFolders = {
    repos_dev = { '~/work/accenture/bayer/repos-dev', '[BayerDev]'},
    repos_infra = { '~/work/accenture/bayer/repos-infra', '[BayerInfra]'},
  }

  for _, v in pairs(commonFolders) do
    local to_replace = v[1]
    local replace_with = v[2]

    if string.match(M.removePathChars(text), M.removePathChars(to_replace)) then
      text = M.replace(text, to_replace, replace_with)
    end
  end

  return text
end

return M
