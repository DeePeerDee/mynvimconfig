return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
      -- Connections defined here
        connections = {
          -- {
          --   name = "my_sqlite",
          --   driver = "sqlite",
          --   source = "mydb.sqlite",  -- path to database file
          -- },
          -- PostgreSQL
          {
            name = "PostgreSQL",
            driver = "postgres",
            source = "host=localhost user=" .. os.getenv("USER") .. " password=" .. os.getenv("DB_PASS") .. " dbname=" .. os.getenv("DB_NAME") .. " port=5432",
          },
          -- {
          --   name = "mysql_db",
          --   driver = "mysql",
          --   source = "myuser:mypass@tcp(localhost:3306)/mydb",
          -- },
          -- {
          --   name = "maria_db",
          --   driver = "mariadb",
          --   source = "myuser:mypass@tcp(localhost:3306)/mydb",
          -- },
        },
      })
    end,
  },
}
