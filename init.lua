-- Basic Editor Settings
vim.opt.shortmess:append('I')    -- Disable intro message
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.laststatus = 2          -- Always show statusline
vim.opt.backspace = 'indent,eol,start'
vim.opt.hidden = true           -- Allow hidden buffers
vim.opt.hlsearch = true         -- Highlight search results
vim.opt.incsearch = true        -- Incremental search
vim.opt.ignorecase = true       -- Case insensitive search
vim.opt.smartcase = true        -- Case sensitive when uppercase present
vim.opt.visualbell = true       -- Visual bell instead of beeping
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftround = true       -- Round indent to multiple of shiftwidth
vim.opt.clipboard = 'unnamed'    -- Use system clipboard
vim.opt.mouse = 'a'             -- Enable mouse support
vim.opt.backup = false          -- Disable backup files
vim.opt.writebackup = false     -- Disable backup files
vim.opt.swapfile = false        -- Disable swap files

-- Visual Customization
vim.opt.colorcolumn = '80'      -- Show column guide at 80 characters
vim.cmd([[highlight ColorColumn ctermbg=233]])
vim.opt.foldmethod = 'indent'   -- Fold based on indentation
vim.opt.foldlevel = 99         -- Start with all folds open

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before loading lazy.nvim
vim.g.mapleader = " "          -- Space as leader key
vim.g.maplocalleader = ","     -- Keeping comma as local leader for compatibility

-- Key Mappings
-- Split navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Toggle search highlighting
vim.keymap.set('n', '<leader>h', ':set hlsearch!<CR>')

-- Save with Ctrl+S
vim.keymap.set('n', '<C-S>', ':update<CR>', { silent = true })
vim.keymap.set('i', '<C-S>', '<C-O>:update<CR>', { silent = true })

-- Insert new lines without entering insert mode
vim.keymap.set('n', '<leader>o', function()
    local count = vim.v.count1
    vim.cmd(string.format('call append(line("."), repeat([""], %d))', count))
end, { silent = true })

vim.keymap.set('n', '<leader>O', function()
    local count = vim.v.count1
    vim.cmd(string.format('call append(line(".")-1, repeat([""], %d))', count))
end, { silent = true })

-- Better indentation in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Sort selection
vim.keymap.set('v', '<Leader>s', ':sort<CR>')

-- Filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.autoindent = true
        vim.opt_local.fileformat = 'unix'
    end
})

vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.py',
    command = [[call append(0,'#! /usr/bin/env python')]]
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cpp',
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'html',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

-- Plugin configuration with lazy.nvim
require("lazy").setup({
  -- Plugin specifications
  {
    "numToStr/Comment.nvim",    -- Modern commenting plugin
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "ellisonleao/gruvbox.nvim", -- Gruvbox theme
    priority = 1000,            -- Load before other plugins
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = true,
      })
      vim.cmd("colorscheme gruvbox")
      vim.opt.background = "dark"
    end,
  },
  {
    "vimwiki/vimwiki",         -- VimWiki
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",   -- Auto close brackets
    event = "InsertEnter",
    config = true,
  },
  {
    "nvim-tree/nvim-tree.lua", -- File explorer
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<C-t>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "vim",
          "javascript",
          "cpp",
          "html",
        },
        highlight = { enable = true },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}, {
  install = {
    colorscheme = { "gruvbox" },
  },
  checker = {
    enabled = true,            -- Automatic plugin update checking
    notify = true,            -- Show update notifications
  },
  change_detection = {
    enabled = true,           -- Auto-reload config changes
    notify = true,            -- Show reload notifications
  },
})

-- Whitespace highlighting
vim.cmd([[
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]])

-- Remove trailing whitespace
vim.keymap.set('n', '<leader>rs', function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
end, { silent = true })


-- Python file execution setup
-- Simpler, more direct approach using built-in terminal commands
local function execute_python_file()
    -- Save the current file
    vim.cmd('write')
    
    -- Get the file path
    local file = vim.fn.expand('%')
    
    -- Open a terminal in a new split and run the Python file
    vim.cmd('belowright 10split')
    vim.cmd('terminal python3 ' .. vim.fn.shellescape(file))
    
    -- Enter normal mode to allow easy closing of terminal
    vim.cmd('startinsert')
end

-- Map Ctrl+P to execute Python files
vim.keymap.set('n', '<C-p>', execute_python_file, { silent = true, desc = 'Execute Python File' })
vim.keymap.set('i', '<C-p>', '<ESC><C-p>', { silent = true, desc = 'Execute Python File' })

-- Terminal mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Terminal window commands' })
