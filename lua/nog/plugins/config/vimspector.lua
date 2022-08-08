local M = {}

local utils = require "nog.utils"

local vimspector_python = [[
{
  "configurations": {
    "<name>: Launch": {
      "adapter": "debugpy",
      "configuration": {
        "name": "Python: Launch",
        "type": "python",
        "request": "launch",
        "python": "%s",
        "stopOnEntry": true,
        "console": "externalTerminal",
        "debugOptions": [],
        "program": "${file}"
      }
    }
  }
}
]]

--
-- useful package.json task:
-- >> "inspect": "tsc && node --inspect ./build/index.js",
--
-- ^ this will start a node process that is attachable by vimspector using the
-- vscode-node-debug2 DAP. 
--
-- If using typescript, make sure to add this to tsconfig.json:
-- >> "sourceMap": true
-- this will make tsc output sourcemaps to the build dir, and vscode-node-debug2
-- will make vimspector correctly show the equivalent TS code
--
-- The below file sample needs to be placed at the root of the project:
local vimspector_node = [[
{
  "configurations": {
    "run": {
      "adapter": "vscode-node",
      "breakpoints": {
        "exception": {
          "all": "N",
          "uncaught": "N"
        }
      },
      "configuration": {
        "request": "attach",
        "type": "node",
        "stopOnEntry": false,
        "console": "integratedTerminal",
        "program": "${workspaceFolder}/build/index.js",
        "skipFiles": ["node_modules/**/*.js", "<node_internals>/**/*.js"],
        "processId": "${processId}"
      }
    }
  }
}
]]

--- Generate debug profile. Currently for Python only
function M.generate_debug_profile()
  -- Get current file type
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "python" then
    -- Get Python path
    local python3 = vim.fn.exepath "python"
    local debugProfile = string.format(vimspector_python, python3)

    -- Generate debug profile in a new window
    vim.api.nvim_exec("vsp", true)
    local win = vim.api.nvim_get_current_win()
    local bufNew = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(bufNew, ".vimspector.json")
    vim.api.nvim_win_set_buf(win, bufNew)

    local lines = {}
    for s in debugProfile:gmatch "[^\r\n]+" do
      table.insert(lines, s)
    end
    vim.api.nvim_buf_set_lines(bufNew, 0, -1, false, lines)
  elseif  ft == "javascript" then
    -- Get node path
    local node_path = "/home/nog/.nvm/versions/node/v18.7.0/bin/node"
    local debugProfile = string.format(vimspector_node, node_path)

    -- Generate debug profile in a new window
    vim.api.nvim_exec("vsp", true)
    local win = vim.api.nvim_get_current_win()
    local bufNew = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(bufNew, ".vimspector.json")
    vim.api.nvim_win_set_buf(win, bufNew)

    local lines = {}
    for s in debugProfile:gmatch "[^\r\n]+" do
      table.insert(lines, s)
    end
    vim.api.nvim_buf_set_lines(bufNew, 0, -1, false, lines)
  else
    utils.info("Unsupported language - " .. ft, "Generate Debug Profile")
  end
end

function M.toggle_human_mode()
  if vim.g.vimspector_enable_mappings == nil then
    vim.g.vimspector_enable_mappings = "HUMAN"
    utils.info("Enabled HUMAN mappings", "Debug")
  else
    vim.g.vimspector_enable_mappings = nil
    utils.info("Disabled HUMAN mappings", "Debug")
  end
end

function M.setup()
  utils.info("Starting setup...", "Vimspector")
  vim.g.vimspector_install_gadgets = {
    "debugpy", -- Python
    "vscode-node-debug2", -- node
  }
  vim.cmd [[packadd! vimspector]] -- Load vimspector
end

return M
