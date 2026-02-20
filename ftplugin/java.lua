local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
if project_name == "" then project_name = "default" end
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local launchers = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)
local path_to_launcher = launchers[1]

if not path_to_launcher or path_to_launcher == "" then
  vim.notify("JDTLS Launcher not found!", vim.log.levels.ERROR)
  return
end

local path_to_config = jdtls_path .. "/config_linux"
local path_to_lombok = jdtls_path .. "/lombok.jar"

local function jdtls_code_action(filter)
  vim.lsp.buf.code_action({
    context = {
      only = { "source.generate" },
      diagnostics = {},
    },
    filter = filter,
  })
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. path_to_lombok,
    "-jar", path_to_launcher,
    "-configuration", path_to_config,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      gradle = { enabled = true },
      import = {
        gradle = { enabled = true },
        maven = { enabled = true },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.junit.jupiter.api.Assertions.*",
        },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk",
          },
          {
            name = "JavaSE-25",
            path = "/usr/lib/jvm/java-25-openjdk",
          },
        }
      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
      codeGeneration = {
        generateComments = true,
        hashCodeEquals = { useJava7Objects = true },
        toString = {
          template = "${object.className} [${member.names()}]",
        },
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
  },

  on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    
    -- Standard LSP keymaps
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    -- Show all code actions
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- Generate getters and setters
    vim.keymap.set('n', '<leader>cgg', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate Getters and Setters")
      end)
    end, bufopts)
    -- Generate getters only
    vim.keymap.set('n', '<leader>cgl', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate Getters")
      end)
    end, bufopts)
    -- Generate setters only
    vim.keymap.set('n', '<leader>csl', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate Setters")
      end)
    end, bufopts)
    -- Generate toString
    vim.keymap.set('n', '<leader>ct', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate toString")
      end)
    end, bufopts)
    -- Generate hashCode and equals
    vim.keymap.set('n', '<leader>ch', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate hashCode")
      end)
    end, bufopts)
    -- Generate constructor
    vim.keymap.set('n', '<leader>cco', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate Constructor")
      end)
    end, bufopts)
    -- Generate equals and hashCode
    vim.keymap.set('n', '<leader>ceq', function()
      jdtls_code_action(function(action)
        return action.title:match("Generate equals")
      end)
    end, bufopts)
    -- Organize imports
    vim.keymap.set('n', '<leader>oi', function()
      require("jdtls").organize_imports()
    end, bufopts)
    -- Extract to variable
    vim.keymap.set('n', '<leader>ev', function()
      require("jdtls").extract_variable(true)
    end, bufopts)
    -- Extract to method
    vim.keymap.set('n', '<leader>em', function()
      require("jdtls").extract_method()
    end, bufopts)
    -- Diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  end,
}

require("jdtls").start_or_attach(config)
