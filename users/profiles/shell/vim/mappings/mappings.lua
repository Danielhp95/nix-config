local wk = require('which-key')

-- Miscelaneous small quality of life stuff
wk.register({
  H = { "<cmd>tabp<cr>", "Previous tab" },
  L = { "<cmd>tabn<cr>", "Next tab" },
  ["<C-Up>"] = {"<cmd>resize -1<cr>", "Continuous window vertical resize" },
  ["<C-Down>"] = {"<cmd>resize +1<cr>", "Continuous window vertical resize" },
  ["<C-Left>"] = {"<cmd>vertical resize +1<cr>", "Continuous window horizontal resize" },
  ["<C-Right>"] = {"<cmd>vertical resize -1<cr>", "Continuous window horizontal resize" },
  ['<leader>tw'] = {"<cmd>set wrap!<cr>", "Toggle wrap" },
  ["<C-s><C-s>" ] = {"<cmd>w<cr>", "Save buffer"},
})

-- Fugitive, git stuff
wk.register({
  ['<leader>'] = {
    g = {
      name = "Fugitive",
      s = {"<cmd>Git<cr>", "Git status half screen" },
      S = {"<cmd>Gtabedit :<cr>", "Git status new tab" },
      a = {"<cmd>Git add %:p<cr>", "Git add file" },
      c = {"<cmd>Git commit<cr>", "Git commit" },
      t = {"<cmd>Gitsigns toggle_signs<cr>", "Toggle gitsigns" },
      -- Do something about blame lines?
      h = {
        name = "+hunks",
        s = {"<cmd>lua require('gitsigns').preview_hunk()<CR>", "Show hunk diff"},
        n = {"<cmd>lua require('gitsigns').next_hunk({wrap = true})<CR>", "Next hunk"},
        p = {"<cmd>lua require('gitsigns').prev_hunk({wrap = true})<CR>", "Previous hunk"},
      },
    }
  }
})

-- Telescope
wk.register({
  ['<leader>'] = {
    t = {
      name = 'Telescope',
      f = {"<cmd>Telescope find_files<CR>", "Find files"},
      g = {"<cmd>Telescope live_grep<CR>", "Live grep"},
      b = {"<cmd>Telescope buffers<CR>", "Buffers"},
      h = {"<cmd>Telescope help_tags<CR>", "NVIM help"},
      k = {"<cmd>Telescope keymaps<CR>", "Keymaps"},
      p = {"<cmd>Telescope project<CR>", "Projects"},
      o = {"<cmd>Telescope oldfiles<CR>", "Last opened files"},
      t = {"<cmd>Telescope<CR>", "Default telescope"},
      s = {"<cmd>Telescope lsp_document_symbols<CR>", "Buffer lsp symbols"},
      S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace lsp symbols"},
    },
  }
})

-- Spelling
wk.register({
  ['<leader>'] = {
    s = {
      name = 'Spelling',
      n = {"]s", "Next spelling error"},
      p = {"[s", "Previous spelling error"},
      s = {"<cmd>lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor())<cr>", "Suggestion"},
      a = {"zg", "Add to dictionary"},
      t = {"<cmd>set spell!<cr>", "Toggle spell check"}
    }
  }
})

-- LSP
wk.register({
  K = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation"},
  ['<leader>'] = {
    l = {
      name = 'LSP functionality',
      r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
      s = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help"},
      g = {
        name = 'Goto ...',
        D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration"},
        d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition"},
        i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation"},
        r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Show references"},
      },
    },
  }
})

-- Diagnostics
wk.register({
  ['<leader>'] = {
    d = {
      name = 'Diagnostics',
      n = {'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Next diagnostic"},
      p = {'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Next diagnostic"},
      s = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostic under cursor"},
      -- TODO: add Trouble plugin!
    }
  }
})

-- Comments
wk.register({
  ['<leader>'] = {
      c = {
        name = 'Comments',
        l = {"<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "Line comment"},
        b = {"<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>", "Block comment"},
    }
  }
})
