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
      name = "+fugitive",
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
      t = {"<cmd>Telescope<CR>", "Default telescope"},
      s = {"<cmd>Telescope lsp_document_symbols<CR>", "Buffer lsp symbols"},
      S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace lsp symbols"},
    },
  }
})
