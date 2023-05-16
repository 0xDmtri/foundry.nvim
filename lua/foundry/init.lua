local remap = require('foundry.remappings')

-- Create user command to load remappings from txt.
vim.api.nvim_create_user_command('LoadForgeRemap', remap.load_remappings, {})

-- Create user command to generate and load remappings.
vim.api.nvim_create_user_command('ForgeRemap', function()
  remap.generate_remappings()
  remap.load_remappings()
end, {})

-- Create autocmd to generate and load remappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('forge', { clear = true }),

  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.name == 'solidity' then
      remap.load_remappings()
    else
      return
    end
  end
})
