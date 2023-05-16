local utils = require('foundry.utils')

local M = {}

-- remappings file name.
M.remap_file = 'remappings.txt'

function M.load_remappings()
  local client = vim.lsp.get_active_clients({ name = 'solidity' })[1]

  -- Check if LSP client is attached
  if client == nil then
    print('No LSP client found!')
    return
  end

  -- Save temp defaults
  local defaults = client.config.settings


  -- Check if file exists, if not, terminate with msg.
  if not utils.file_exists(M.remap_file) then
    print('No ' .. M.remap_file .. ' found! Call ":ForgeRemap"')
    return
  end

  -- Handle remappings.
  local lines = utils.lines_from(M.remap_file)
  local remap_tab = utils.get_tab(lines)
  local new_settings = {
    solidity = {
      includePath = "",
      remapping = remap_tab,
    }
  }

  -- Edit workspace with new settings.
  local ok, err = pcall(client.notify, 'workspace/didChangeConfiguration', {
    settings = vim.tbl_deep_extend('force', defaults, new_settings)
  })

  -- Check if successfull, if not print error.
  if not ok then
    print(err)
  end
end

function M.generate_remappings()
  -- FIXME: non optimal way, reimplement with vim.fn.chansend.
  io.popen('forge remappings > ' .. M.remap_file)
end

return M
