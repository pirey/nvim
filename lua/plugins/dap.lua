-- install dlv
-- go install github.com/go-delve/delve/cmd/dlv@latest
return {
  "leoluz/nvim-dap-go",
  dependencies = { "mfussenegger/nvim-dap" },
  ft = "go",
  opts = {},
}
