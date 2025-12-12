return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", version = "^1.0.0" },
            { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "Hoffs/omnisharp-extended-lsp.nvim"
        },

        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "glsl_analyzer",
                    "omnisharp",
                    "yamlls",
                    "pylsp"
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
            local luasnip = require("luasnip")

            -- nvim-cmp ---------------------------------------------------------------
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" }
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                completion = {
                    keyword_length = 2,
                },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, _)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
                vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            end

            -- New Neovim 0.11+ style: assign config tables to vim.lsp.config[...] ----
            vim.lsp.config["lua_ls"] = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            vim.lsp.config["pylsp"] = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            vim.lsp.config["clangd"] = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            vim.lsp.config["glsl_analyzer"] = {
                filetypes = { "glsl", "vert", "frag", "geom" },
                on_attach = on_attach,
                capabilities = capabilities,
            }

            -- OmniSharp ---------------------------------------------------------------
            local omnisharp_bin = "/home/charlie/Omnisharp/OmniSharp.dll"

            local on_attach_csharp = function(_, _)
                -- use omnisharp_extended correctly
                vim.keymap.set("n", "gd", require("omnisharp_extended").lsp_definition, {})
                vim.keymap.set("n", "<leader>D", require("omnisharp_extended").lsp_type_definition, {})
                vim.keymap.set("n", "gr", require("omnisharp_extended").lsp_references, {})
                vim.keymap.set("n", "gi", require("omnisharp_extended").lsp_implementation, {})

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            end

            vim.lsp.config["omnisharp"] = {
                on_attach = on_attach_csharp,
                capabilities = capabilities,
                cmd = { "dotnet", omnisharp_bin },

                enable_editorconfig_support = true,
                enable_ms_build_load_projects_on_demand = true,
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_import_completion = true,
                sdk_include_prereleases = true,
                analyze_open_documents_only = false,
            }
        end
    }
}
