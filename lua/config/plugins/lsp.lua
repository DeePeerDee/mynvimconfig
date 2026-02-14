return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "clangd",
          "rust_analyzer",
          "jdtls",
          "lemminx",
          "gradle_ls",
          "yamlls",
          "html",
          "cssls"
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.iter(mason_lspconfig.get_installed_servers()):each(function(server_name)

        if server_name == "jdtls" then return end


        local config = require("lspconfig.configs." .. server_name)

        if config then
          config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities)

          if server_name == "lua_ls" then
            config.settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            }
          elseif server_name == "clangd" then
            config.capabilities.offsetEncoding = { "utf-16" }
          elseif server_name == "yamlls" then
            config.settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/spring-boot-properties-2.7.json"] = "application.yaml",
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                },
                completion = true,
                hover = true,
                validate = true,
              },
            }
          elseif server_name == "lemminx" then
            config.settings = {
              xml = {
                server = { vmargs = "-Xmx512m" },
                maven = {
                  fetchExternalResources = true,
                  repositories = {
                    {
                      id = "local",
                      url = "file://" .. os.getenv("HOME") .. "/.m2/repository",
                    },
                    {
                      id = "central",
                      url = "https://repo1.maven.org/maven2",
                    }
                  },
                  updateSchedule = "daily",
                },
                completion = {
                  autoCloseTags = true,
                },
                catalogs = {}
              }
            }
          elseif server_name == "gradle_ls" then
            config.filetypes = { "gradle" }
          end

          vim.lsp.config(server_name, config)
        end
      end)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if vim.bo.filetype ~= "java" then
            vim.lsp.start(args.file)
          end
        end
      })
    end,
  },
}
