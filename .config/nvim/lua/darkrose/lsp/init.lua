local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "darkrose.lsp.lsp-installer"
require("darkrose.lsp.handlers").setup()
require "darkrose.lsp.null-ls"
