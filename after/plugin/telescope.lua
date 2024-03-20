local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>g', builtin.find_files, {})
