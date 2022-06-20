--local M = {}
--local extension_path = '/Users/alvaro/.vscode/extensions/vadimcn.vscode-lldb-1.6.8/'
--local codelldb_path = extension_path .. 'adapter/codelldb'
--local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

-- Normal setup
require'lspconfig'.rnix.setup{}
require('rust-tools').setup{
    --dap = {
    --    adapter = require('rust-tools.dap').get_codelldb_adapter(
    --        codelldb_path, liblldb_path)
    --},

    tools = {
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        },

        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            full = true,
        }

    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        on_attach =  function(_, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Enable completion triggered by <c-x><c-o>
            -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', '<leader>uu', '<cmd>RustRunnables<CR>', opts)
            buf_set_keymap('n', '<leader>uU', '<cmd>RustDebuggables<CR>', opts)
            buf_set_keymap('n', '<leader>u<CR>', '<cmd>lua require"dap".continue()<CR>', opts)
            buf_set_keymap('n', 'J', '<cmd>RustJoinLines<CR>', opts)
            buf_set_keymap('n', '[p', '<cmd>RustMoveItemUp<CR>', opts)
            buf_set_keymap('n', ']p', '<cmd>RustMoveItemDown<CR>', opts)
            vim.cmd [[
            augroup rustfmt
                au!
                autocmd BufWritePre *.rs :silent! lua vim.lsp.buf.formatting_sync(nil,500)
            augroup end]]
        end
    },
}

--return M
