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

      mason.setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:crashdummyy/mason-registry",
        }
      })
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
          "html",
          "cssls",
          "gopls",
          "intelephense",
          "ruby_lsp",
          "solargraph",
          "asm_lsp",
          "bashls",
          "powershell_es",
          "dockerls",
          "neocmake",
          "emmet_language_server",
          "eslint",
          -- "nginx_language_server",
          "postgres_lsp",
          "zls"

        },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.filetype.add({
        filename = {
          ["pom.xml"] = "xml",
        },
      })

      vim.iter(mason_lspconfig.get_installed_servers()):each(function(server_name)

        if server_name == "jdtls" then
          return
        end

        local config = require("lspconfig.configs." .. server_name)

        if config then
          config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities)

          if server_name == "lua_ls" then
            config.settings = {
              Lua = {
--                runtime = { version = "Lua 5.1" },
                diagnostics = { globals = { "vim" } },
              },
            }
          elseif server_name == "ts_ls" then
            config.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
            config.settings = {
              typescript = {
                suggest = {
                  autoImports = true,
                  completeFunctionCalls = true,
                },
                updateImportsOnFileMove = { enabled = "always" },
              },
              javascript = {
                suggest = {
                  autoImports = true,
                  completeFunctionCalls = true,
                },
                updateImportsOnFileMove = { enabled = "always" },
              },
            }
          elseif server_name == "pyright" then
            config.single_file_support = true
            config.filetypes = { "python", "ipynb" }
          elseif server_name == "clangd" then
            config.capabilities.offsetEncoding = { "utf-16" }
          elseif server_name == "intelephense" then
            config.settings = {
              intelephense = {
                files = { maxSize = 1000000 },
                -- If you have a license, you can point to it here or at ~/intelephense/licence.txt
              }
            }  
          elseif server_name == "gopls" then
            config.settings = {
              gopls = {
                analyses = { unusedparams = true },
                staticcheck = true,
                completeUnimported = true,
              },
            }
          elseif server_name == "ruby_lsp" then
            config.init_options = {
              formatter = 'standard', -- or 'rubocop'
              linters = { 'standard' },
            }
          elseif server_name == "gradle_ls" then
            local util = require("lspconfig.util")

            config.filetypes = { "gradle", "kotlin", "groovy" }
            config.root_dir = util.root_pattern(
              "settings.gradle",
              "settings.gradle.kts",
              "build.gradle",
              "build.gradle.kts",
              "gradlew",
              ".git"
            )

            config.init_options = {
              settings = {
                gradle = {
                  wrapper = { enabled = true },
                  build = { enable = true },
                  completion = { enabled = true },
                  hover = { enabled = true },
                  validation = { enabled = true },
                  downloadSources = true
                },
                gradleJvm = {
                  javaHome = os.getenv("JAVA_HOME") or "/usr/lib/jvm/jre-25-openjdk",
                },
              }
            }
          elseif server_name == "lemminx" then
            config.filetypes = { "xml", "xsd", "xslt", "pom" }
            config.init_options = {
              settings = {
                xml = {
                  fileAssociations = {
                    pattern = "pom.xml",
                    systemId = "https://maven.apache.org/xsd/maven-4.0.0.xsd"
                  },
                  server = { vmargs = "-Xmx2g" },
                  format = { enabled = true },
                  maven = {
                    enabled = true,
                    downloadSources = true,
                    downloadResources = true,
                    fetchExternalResources = true, -- Crucial for downloading XSDs/Schemas
                    updateSchedule = "onDemand",
                    central = {
                      enabled = true,
                    },
                    updateSnapshots = true,
                    index = {
                      enabled = true,
                    },
                    repositories = {
                      {
                        id = "central",
                        url = "https://repo1.maven.org/maven2",
                        layout = "default",
                      },
                      {
                        id = "local",
                        url = "file://" .. os.getenv("HOME") .. "/.m2/repository",
                      }
                    }
                  },
                  completion = {
                    autoCloseTags = true,
                    autoCloseRemovableContent = true,
                  },
                  validation = {
                    enabled = true,
                    resolveExternalEntities = true,
                  },
                  -- Force the schema if it's not being picked up automatically
                  catalogs = {},
                },
              },
            }
          end

          vim.lsp.config(server_name, config)
        end
      end)
    end,
  },
}
