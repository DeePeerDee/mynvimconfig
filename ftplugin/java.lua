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
      maven = { downloadSources = true },
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
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
  },
}

require("jdtls").start_or_attach(config)
