return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
        -- Telescope is a fuzzy finder that comes with a lot of different things that
        -- it can fuzzy find! It's more than just a "file finder", it can search
        -- many different aspects of Neovim, your workspace, LSP, and more!
        --
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags
        --
        -- After running this command, a window will open up and you're able to
        -- type in the prompt window. You'll see a list of `help_tags` options and
        -- a corresponding preview of the help.
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!

        local pickerLayout = {
            theme = "ivy",
            layout_config = {
                height = 20,
                preview_width = 0.6,
            },
            borderchars = {
                "z",
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { " " },
                -- results = { "a", "b", "c", "d", "e", "f", "g", "h" },
                -- preview = { " " },
                preview = { " ", "│", " ", "│", " ", " ", " ", " " },
                -- preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
        }

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            defaults = {
                -- layout_strategy = "ivy",
                -- layout_config = {
                --   height = 0.5,
                --   -- other layout_config options
                -- },
                path_display = {
                    shorten = {
                        len = 1,
                        exclude = { -1, -2 },
                    },
                },
                -- mappings = {
                --     i = { ["<c-enter>"] = "to_fuzzy_refine" },
                -- },
            },
            pickers = {
                find_files = pickerLayout, -- Lists files in your current working directory, respects .gitignore
                git_files = pickerLayout, -- Fuzzy search through the output of git ls-files command, respects .gitignore
                grep_string = pickerLayout, -- Searches for the string under your cursor or selection in your current working directory
                live_grep = pickerLayout, -- Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)
                buffers = pickerLayout, -- Lists open buffers in current neovim instance
                oldfiles = pickerLayout, -- Lists previously open files
                commands = pickerLayout, -- Lists available plugin/user commands and runs them on <cr>
                tags = pickerLayout, -- Lists tags in current directory with tag location file preview (users are required to run ctags -R to generate tags or update when introducing new changes)
                command_history = pickerLayout, -- Lists commands that were executed recently, and reruns them on <cr>
                search_history = pickerLayout, -- Lists searches that were executed recently, and reruns them on <cr>
                help_tags = pickerLayout, -- Lists available help tags and opens a new window with the relevant help info on <cr>
                man_pages = pickerLayout, -- Lists manpage entries, opens them in a help window on <cr>
                marks = pickerLayout, -- Lists vim marks and their value
                colorscheme = pickerLayout, -- Lists available colorschemes and applies them on <cr>
                quickfix = pickerLayout, -- Lists items in the quickfix list
                quickfixhistory = pickerLayout, -- Lists all quickfix lists in your history and open them with builtin.quickfix or quickfix window
                loclist = pickerLayout, -- Lists items from the current window's location list
                jumplist = pickerLayout, -- Lists Jump List entries
                vim_options = pickerLayout, -- Lists vim options, allows you to edit the current value on <cr>
                registers = pickerLayout, -- Lists vim registers, pastes the contents of the register on <cr>
                autocommands = pickerLayout, -- Lists vim autocommands and goes to their declaration on <cr>
                spell_suggest = pickerLayout, -- Lists spelling suggestions for the current word under the cursor, replaces word with selected suggestion on <cr>
                keymaps = pickerLayout, -- Lists normal mode keymappings
                filetypes = pickerLayout, -- Lists all available filetypes
                highlights = pickerLayout, -- Lists all available highlights
                current_buffer_fuzzy_find = pickerLayout, -- Live fuzzy search inside of the currently open buffer
                current_buffer_tags = pickerLayout, -- Lists all of the tags for the currently open buffer, with a preview
                resume = pickerLayout, -- Lists the results incl. multi-selections of the previous picker
                pickers = pickerLayout, -- Lists the previous pickers incl. multi-selections (see :h telescope.defaults.cache_picker)
                lsp_references = pickerLayout, -- Lists LSP references for word under the cursor
                lsp_incoming_calls = pickerLayout, -- Lists LSP incoming calls for word under the cursor
                lsp_outgoing_calls = pickerLayout, -- Lists LSP outgoing calls for word under the cursor
                lsp_document_symbols = pickerLayout, -- Lists LSP document symbols in the current buffer
                lsp_workspace_symbols = pickerLayout, -- Lists LSP document symbols in the current workspace
                lsp_dynamic_workspace_symbols = pickerLayout, -- Dynamically Lists LSP for all workspace symbols
                diagnostics = pickerLayout, -- Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
                lsp_implementations = pickerLayout, -- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
                lsp_definitions = pickerLayout, -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
                lsp_type_definitions = pickerLayout, -- Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope
                git_commits = pickerLayout, -- Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h
                git_bcommits = pickerLayout, -- Lists buffer's git commits with diff preview and checks them out on <cr>
                git_bcommits_range = pickerLayout, -- Lists buffer's git commits in a range of lines. Use options from and to to specify the range. In visual mode, lists commits for the selected lines
                git_branches = pickerLayout, -- Lists all branches with log preview, checkout action <cr>, track action <C-t>, rebase action<C-r>, create action <C-a>, switch action <C-s>, delete action <C-d> and merge action <C-y>
                git_status = pickerLayout, -- Lists current changes per file with diff preview and add action. (Multi-selection still WIP)
                git_stash = pickerLayout, -- Lists stash items in current repository with ability to apply them on <cr>
                treesitter = pickerLayout, -- Lists Function names, variables, from Treesitter!
                planets = pickerLayout, -- Use the telescope...
                builtin = pickerLayout, -- Lists Built-in pickers and run them on <cr>.
                reloader = pickerLayout, -- Lists Lua modules and reload them on <cr>.
                symbols = pickerLayout, -- Lists symbols inside a file data/telescope-sources/*.json found in your rtp. More info and symbol sources
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_ivy(),
                },
                fzf = {},
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
    end,
}
