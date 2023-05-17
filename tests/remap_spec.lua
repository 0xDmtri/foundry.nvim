-- force start solidity LSP
vim.cmd([[LspStart solidity]])

describe('foundry', function()
  -- test if it can load mappings
  it('can load remappings', function()
    local remap = require('foundry.remappings')
    local client = vim.lsp.get_active_clients({ name = 'solidity' })[1]

    if client == nil then
      print('No LSP client found!')
      return
    end

    -- Save current settings
    local config = client.config
    print(vim.inspect(config))

    -- -- load remappings
    -- remap.load_remappings()
    --
    -- local new_client = vim.lsp.get_active_clients({ name = 'solidity' })[1]
    -- local new_settings = new_client.config.settings
    -- print(vim.inspect(new_settings))
  end)
end)
