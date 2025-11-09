return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        terminal_colors = true,
        styles = {
          commments = "undercurl",
          keywords = "bold",
          types = "italic,bold",
        },
        inverse = {
          match_paren = true,
          visual = true,
          search = true,
        },
        darken = {
          floats = false,
        },
      })
      vim.cmd("colorscheme github_dark")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_dimmed",
    },
  },
}
