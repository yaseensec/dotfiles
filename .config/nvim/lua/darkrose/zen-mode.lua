local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

local status_ok, twilight = pcall(require, "twilight")
if not status_ok then
  return
end

zen_mode.setup{
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 100, -- width of the Zen window
    height = 0.8, -- height of the Zen window
    options = {
      signcolumn = "no",
      number = false,
      cursorline = false
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
  },
}

twilight.setup{
  dimming = {
    alpha = 0.25, -- amount of dimming
    color = { "Normal", "#ffffff" },
    inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
}
