local notes_folder = os.getenv("HOME") .. "/notes";

local M = {}

function M.open_note(note_name)
  if not note_name then
    note_name = os.date("%Y-%m-%d.md")
  end

  if vim.call("isdirectory", notes_folder) == 0 then
    vim.call("mkdir", notes_folder, "p")
  end

  local full_path = notes_folder .. "/" .. note_name

  vim.api.nvim_cmd({
    cmd = 'e',
    args = { full_path },
    bang = true
  }, {})

  vim.api.nvim_cmd({
    cmd = 'w'
  }, {})
end

function M.list_notes()
  vim.api.nvim_echo({ { "Not implemented yet!" } }, false, {})
end

return M
