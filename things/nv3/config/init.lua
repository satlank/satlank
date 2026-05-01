----------------------------------------------------------------------
--  Neovim ≥0.12 Minimal Init (single‑file, sectioned)
----------------------------------------------------------------------

------------------------------
-- Helper utilities
------------------------------
local is_root = vim.env.USER == 'root'     -- detect “running as root”

-- Below is the fix double-slash at the end of the paths, not sure if that is a
-- bug in neovim, but I am getting `<data_dir>/backup//` by default; overriding it
-- here makes it `<data_dir>/backup` (check with `:echo &backupdir` for example)
local data_dir = vim.fn.stdpath("data")
vim.opt.undodir = data_dir .. "/undo"
vim.opt.backupdir = data_dir .. "/backup"
vim.opt.directory = data_dir .. "/swap"
vim.opt.viewdir = data_dir .. "/view"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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

----------------------------------------------------------------------
-- Core Options / Settings
----------------------------------------------------------------------
local notes_path = vim.fn.expand('~/srk/notes')

-- UI -----------------------------------------------------------------
vim.opt.termguicolors  = true          -- true‑color support
vim.opt.number         = true          -- absolute line numbers
vim.opt.relativenumber = false         -- (set true if you like them)
vim.opt.cursorline     = false         -- highlight current line
vim.opt.signcolumn     = "auto:2"      -- automatically add the gutter when needed
vim.opt.showcmd        = false         -- we don’t need the extra cmd hint
vim.opt.laststatus     = 3             -- global status line (good for split views)
vim.opt.background     = "dark"

-- Editing behaviour --------------------------------------------------
vim.opt.autoindent   = true           -- keep current indent on <Enter>
vim.opt.expandtab    = true           -- convert tabs to spaces by default, this battle is lost
vim.opt.shiftwidth   = 2              -- width of an indentation level
vim.opt.tabstop      = 4              -- visual width of a tab character
vim.opt.softtabstop  = -1             -- use shiftwidth for <Tab>/<BS>
vim.opt.smarttab    = true           -- smart indent/dedent in leading ws
vim.opt.shiftround   = false          -- don’t round to multiple of sw

-- Whitespace display -------------------------------------------------
vim.opt.list         = true
vim.opt.listchars = {
  nbsp  = '⦸',   -- non‑break space
  extends = '»',
  precedes = '«',
  tab   = '▸ ', -- triangle + space
  trail = '·',
}
vim.opt.fillchars = {
  diff = '∙',
  fold = '·',
  vert = '┃',
  eob  = ' ',   -- hide the “~” at end‑of‑buffer
}

-- Folding ------------------------------------------------------------
vim.opt.foldmethod      = 'indent'
vim.opt.foldlevelstart  = 99            -- start with everything unfolded
vim.opt.foldminlines    = 0

-- Searching ----------------------------------------------------------
vim.opt.ignorecase   = true
vim.opt.smartcase    = true
vim.opt.inccommand   = 'split'        -- live preview of :s
vim.opt.linebreak    = true
vim.opt.showbreak    = '↪ '

-- History & Undo -----------------------------------------------------
vim.opt.history      = 1000
vim.opt.undofile     = not is_root

-- Backup / Swap ------------------------------------------------------
vim.opt.backup       = true
vim.opt.writebackup  = true
vim.opt.swapfile     = true
vim.opt.belloff      = 'all'          -- no audible bell
vim.opt.visualbell   = true           -- visual bell instead

-- Clipboard ---------------------------------------------------------
vim.opt.clipboard        = "unnamedplus" -- yank goes to system clipboard

-- Misc ---------------------------------------------------------------
vim.opt.modelines        = 5
vim.opt.scrolloff        = 3
vim.opt.sidescrolloff    = 3
vim.opt.sidescroll       = 0
vim.opt.splitbelow       = true
vim.opt.splitright       = true
vim.opt.switchbuf        = 'usetab'
vim.opt.synmaxcol        = 500
vim.opt.textwidth        = 80
vim.opt.virtualedit      = 'block'
vim.opt.whichwrap        = 'b,s,<,>,[,],~'
vim.opt.wildmenu         = true
vim.opt.wildmode         = "longest:full,full"

-- Short messages (quiet UI) -----------------------------------------
vim.opt.shortmess:append('A')   -- suppress swapfile msgs
vim.opt.shortmess:append('I')   -- no intro screen
vim.opt.shortmess:append('O')   -- overwrite file‑read msgs
vim.opt.shortmess:append('T')   -- truncate non‑file msgs
vim.opt.shortmess:append('W')   -- don’t echo “[w]”/“[written]”
vim.opt.shortmess:append('a')   -- abbreviate messages (e.g. [RO])
vim.opt.shortmess:append('c')   -- completion msgs
vim.opt.shortmess:append('o')   -- overwrite file‑written msgs
vim.opt.shortmess:append('t')   -- truncate start of file msgs

-- Format options ------------------------------------------------------
vim.opt.formatoptions:append('j')  -- remove comment leader when joining lines
vim.opt.formatoptions:append('n')  -- smart indent inside numbered lists
vim.opt.joinspaces = true          -- two spaces after ., ?, !

-- Shell --------------------------------------------------------------
vim.opt.shell = 'sh'

----------------------------------------------------------------------
-- Core Keymaps (stock only)
----------------------------------------------------------------------
local map = vim.keymap.set

vim.g.mapleader        = ' '
vim.g.maplocalleader   = '\\'

-- Clear search highlighting
map('n', '<Leader>h', ':nohlsearch<CR>', { desc = 'Clear hlsearch' })

-- Save / quit shortcuts
map('n', '<Leader>w', ':w<CR>',          { desc = 'Write file' })
map('n', '<Leader>q', ':qa<CR>',         { desc = 'Quit all' })
map('n', '<Leader>x', ':xa<CR>',         { desc = 'Write + quit' })

-- Buffer navigation
map('n', '<Leader>bn', ':bnext<CR>',     { desc = 'Next buffer' })
map('n', '<Leader>bp', ':bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<Leader>bd', ':bdelete<CR>',   { desc = 'Delete buffer' })

-- Window navigation (Ctrl‑hjkl)
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-j>', '<C-w>j', { silent = true })
map('n', '<C-k>', '<C-w>k', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })

-- Resize splits
map('n', '<Leader><', ':vertical resize -2<CR>', { desc = 'Shrink vertical split' })
map('n', '<Leader>>', ':vertical resize +2<CR>', { desc = 'Grow vertical split' })
map('n', '<Leader>-', ':resize -2<CR>',          { desc = 'Shrink horizontal split' })
map('n', '<Leader>=', ':resize +2<CR>',          { desc = 'Grow horizontal split' })

-- Insert‑mode quick escape (jk → <Esc>)
map('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Open last buffer short-cut
map('n', '<Leader><Leader>', '<C-^>', { noremap = true, silent = true, desc = "Toggle to previous buffer" })

-- Toggle list symbols on/off
map('n', '<Leader>l', ':set list!<CR>', { noremap = true, silent = true, desc = "Toggle list symbols on/off" })

----------------------------------------------------------------------
-- Spelling things (buffer‑aware)
----------------------------------------------------------------------
local spell = { langs = { "de", "en_gb" } }

--- Return the buffer number to use.
--- If `buf` is nil we fall back to the current buffer.
---@param buf? integer   Buffer handle (may be nil)
---@return integer       Valid buffer number
local function resolve_buf(buf)
  return buf or vim.api.nvim_get_current_buf()
end

--- Enable spelling for a specific buffer (or the current one).
--- Sets:
---   * `spelllang` – buffer‑local language list.
---   * `spell`     – window‑local flag for the **current** window that shows this buffer.
---@param buf? integer   Buffer handle (optional)
function spell.enable(buf)
  if vim.fn.has("syntax") ~= 1 then return end

  local b = resolve_buf(buf)

  -- language is a *buffer‑local* option
  vim.bo[b].spelllang = "en_gb"

  -- `spell` itself lives in the window, so we use the *current* window.
  -- (If you ever need to turn it on for every window that shows this buffer,
  -- you would have to iterate over the windows – not needed for our use‑case.)
  vim.opt_local.spell = true
end

--- Cycle through the languages defined in `spell.langs`.
--- Only the *language* (`spelllang`) is changed; the current window’s
--- `spell` flag stays as it was.
---@param buf? integer   Buffer handle (optional)
function spell.cycle(buf)
  local b = resolve_buf(buf)

  local cur = vim.bo[b].spelllang                -- buffer‑local value
  local idx = vim.fn.index(spell.langs, cur) or -1
  local nexti = (idx + 1) % #spell.langs
  local new   = spell.langs[nexti + 1]           -- Lua tables are 1‑based

  vim.bo[b].spelllang = new                     -- update language for that buffer
  vim.notify("Spell language → " .. new, vim.log.levels.INFO)
end

map('n', '<Leader>ss', function() vim.wo.spell = not vim.wo.spell end, { noremap = true, silent = true })
map('n', '<Leader>s?', 'z=', { noremap = true })
map('n', '<Leader>si', 'zg', { noremap = true, silent = true })
map('n', '<Leader>sl', function() spell.cycle() end, { noremap = true, silent = true })

----------------------------------------------------------------------
-- Plaintext mode
----------------------------------------------------------------------
local plain = {}

function plain.init(bufnr)               -- bufnr may be nil → current buffer
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local opt = vim.bo[bufnr]            -- buffer‑local options shortcut
  opt.textwidth   = 0                  -- setlocal textwidth=0
  opt.wrapmargin  = 0                  -- setlocal wrapmargin=0

  if vim.fn.has('conceal') == 1 then
    vim.opt_local.concealcursor = "nc"           -- setlocal concealcursor=nc
  end
  vim.opt_local.wrap        = true               -- setlocal wrap

  -- Insert‑mode punctuation → break undo blocks --------------------
  local i_opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('i', '!', '!<C-g>u', i_opts)
  vim.keymap.set('i', ',', ',<C-g>u', i_opts)
  vim.keymap.set('i', '.', '.<C-g>u', i_opts)
  vim.keymap.set('i', ':', ':<C-g>u', i_opts)
  vim.keymap.set('i', ';', ';<C-g>u', i_opts)
  vim.keymap.set('i', '?', '?<C-g>u', i_opts)

  -- Normal‑mode j/k → respect wrapped lines ------------------------
  local n_opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'j', 'gj', n_opts)
  vim.keymap.set('n', 'k', 'gk', n_opts)
end

----------------------------------------------------------------------
-- Autocommands (stock only)
----------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Yank highlight -------------------------------------------------------
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group   = 'YankHighlight',
  pattern = '*',
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

-- Spell checking for prose files ---------------------------------------
augroup('PlaintextSetup', { clear = true })
autocmd('FileType', {
  group   = 'PlaintextSetup',
  pattern = { 'markdown', 'asciidoc', 'tex', 'mail', 'typst', 'text' },
  callback = function(ev)
    plain.init(ev.buf)
    spell.enable(ev.buf)
  end,
})

-- Restore last cursor position -----------------------------------------
augroup('LastPos', { clear = true })
autocmd('BufReadPost', {
  group   = 'LastPos',
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Disable copilot in Obsidian vault --------------------------------
augroup('CopilotInObsidian', { clear = true })
autocmd({'BufReadPost', 'BufNewFile'}, {
  group   = 'CopilotInObsidian',
  pattern = '*',
  callback = function(args)
    local bufnr = args.buf
    local filename = vim.api.nvim_buf_get_name(bufnr)

    if filename ~= "" and vim.startswith(filename, notes_path) then
      vim.api.nvim_buf_set_var(bufnr, 'copilot_enabled', false)
    end
  end,
})

----------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------
require("lazy").setup({
  {
    'chriskempson/base16-vim',
    version = '*',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('base16-tomorrow-night')
      -- Clear all LSP highlight groups as I otherwise end up with unwanted
      -- hightlighting in Rust.
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end
  },
  {
    'nvim-mini/mini.icons',
    version = "*",
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master'
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "enter" },
      completion = {
        ghost_text = {
          enabled = true,
          show_with_menu = true,
        },
        menu = {
          auto_show = true,
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
              },
            },
          },
        },
      },
      cmdline = {
        -- disabled here because I can't get used to how blink handles
        -- tab-completion when completing paths
        enabled = false,
      }
    },
    dependencies= {
      'nvim-mini/mini.icons',
    },
  },
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "saghen/blink.cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "vault",
          path = notes_path,
        },
      },
      daily_notes = {
        folder = "daily/",
        -- Match Obsidian date format of, e.g. "2021-08-01_Sun"
        date_format = "%Y-%m-%d_%a",
        template = "daily.md",
        workdays_only = false,
      },
      completion = {
        blink = true,
        nvim_cmp = false,
        min_chars = 2,
      },
      new_notes_location = "current_dir",
      templates = {
        subdir = "assets/templates/",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },
      picker = {
        name = "telescope.nvim",
      },
      ui = {
        enable = false,
      },
      frontmatter = { enabled = false },
      note_id_func = function(title)
        -- Match the ZK Obsidian plugin's note ID format of, e.g. "20210801123456"
        local prefix = os.date("%Y%m%d%H%M%S")
        if title ~= nil and title ~= "" then
          return prefix .. " " .. title
        else
          return prefix
        end
      end,
      callbacks = {
        enter_note = function(_, note)
          vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_link() then
              return "<cmd>Obsidian follow_link<cr>"
            else
              return "gf"
            end
          end, {
            expr = true,
            desc = "[g]o to [f]ile under cursor (Obsidian)",
          })
        end
      },
    }
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<Leader>z", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    },
    opts = {
      window = {
        backdrop = 1,
        width = 80,
        height = 0.95,
        options = {
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          signcolumn = "no",
          list = true,
          foldcolumn = "0",
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        tmux = { enabled = true },
        twilight = { enabled = false },
        kitty = { enabled = true },
        wezterm = { enabled = false },
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = "^6",
    lazy = false,
  },
})

