return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      "codelldb",
      -- Update this to ensure that you have the debuggers for the langs you want
    },
  },
  -- mason-nvim-dap is loaded when nvim-dap loads
  config = function()
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Debug (No Build)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        externalTerminal = false,
        args = {},
      },
      {
        name = "Debug Build Item",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        externalTerminal = false,
        args = {},
      },
    }
  end,
  --
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<F8>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<F9>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
}
