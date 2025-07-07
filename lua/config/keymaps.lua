-- Set leader key to space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true }

--save filg
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "nzzzv", opts)
-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bd!<CR>", opts) -- close buffer
-- tabs
-- window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>o", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window
-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)
-- Navigate between splits
vim.keymap.set("n", "<C-K>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-J>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-H>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-L>", ":wincmd l<CR>", opts)
-- toggle line wrapping
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", opts)
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

vim.api.nvim_set_keymap("t", "<leader>q", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":execute 'vsplit term://bash' | :cd %:p:h<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>h", ":hide<CR>", { noremap = true, silent = true })

-- Set a keybinding for entering Normal mode in terminal
-- Map <Leader>t to open a terminal in the current file's directory
vim.api.nvim_set_keymap("n", "<Leader>t", ":lua OpenTerminalWithCWD()<CR>", { noremap = true, silent = true })

-- Function to open terminal with 'cd' to the current file's directory
function OpenTerminalWithCWD()
  local current_file_dir = vim.fn.expand("%:p:h") -- Get the current file's directory
  vim.cmd("vsplit | terminal") -- Open terminal in a split window
  vim.cmd("startinsert") -- Start in insert mode in terminal
  vim.fn.chansend(vim.b.terminal_job_id, "cd " .. current_file_dir .. "\n") -- Send 'cd' command
end

-- Set a keybinding for entering Normal mode in terminal
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Map 'jj' to escape insert mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Map leader f a to search all files on the system
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  ":lua require('telescope.builtin').find_files({cwd='~/'})<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fF",
  ":lua require('telescope.builtin').find_files({cwd='/'})<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fh",
  ":lua require('telescope.builtin').find_files({cwd='~/.config/hypr'})<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fc",
  ":lua require('telescope.builtin').find_files({cwd='~/.config/'})<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fn",
  ":lua require('telescope.builtin').find_files({cwd='~/.config/nvim'})<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fs",
  ":lua require('telescope.builtin').find_files({cwd='~/.local/share/'})<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<C-w>", ":set wrap<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true })
function OpenTmuxSplit()
  local file_path = vim.fn.expand("%:p:h") -- Get the directory of the current file
  local cmd = "tmux split-window -h -c " .. vim.fn.shellescape(file_path) -- Open tmux split in that directory
  vim.fn.system(cmd)
end

vim.api.nvim_set_keymap("n", "<leader>t", ":lua OpenTmuxSplit()<CR>", { noremap = true, silent = true })
-- lua/user/utils.lua (or similar)
--vim.keymap.set("n", "<leader>b", function()
--  local filepath = vim.fn.expand("%:p")
--  if filepath:match("%.html$") then
--    vim.fn.jobstart({ "firefox", filepath }, { detach = true })
--  else
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Track running live servers
local live_servers = {}

-- Hash dir into unique port between 3000–3999
local function get_port_from_dir(dir)
  local hash = 0
  for i = 1, #dir do
    hash = (hash * 31 + dir:byte(i)) % 10000
  end
  return 3000 + (hash % 1000)
end

-- Check if file is within the directory
local function is_file_in_dir(file, dir)
  return vim.startswith(file, dir)
end

-- Start live-server for current file's dir
map("n", "<leader>bs", function()
  local dir = vim.fn.expand("%:p:h")
  if live_servers[dir] then
    print("Live server already running for: " .. dir)
    return
  end

  local port = get_port_from_dir(dir)
  live_servers[dir] = port

  local cmd = {
    "live-server",
    "--port=" .. port,
    "--quiet",
    "--no-browser",
  }

  vim.fn.jobstart(cmd, {
    cwd = dir,
    detach = true,
    on_exit = function()
      live_servers[dir] = nil
    end,
  })

  print("Live server started at http://localhost:" .. port)
end, opts)

-- Open current file with live server
map("n", "<leader>b", function()
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  local file_name = vim.fn.expand("%:t")

  local port = live_servers[dir] or get_port_from_dir(dir)

  if not is_file_in_dir(file, dir) then
    print("File is not inside live server root: " .. dir)
    return
  end

  local url = string.format("http://localhost:%d/%s", port, file_name)
  vim.fn.jobstart({ "firefox", url }, { detach = true })
end, opts)
--    print("Not an HTML file.")
map("n", "<leader>bx", function()
  local dir = vim.fn.expand("%:p:h")
  local port = live_servers[dir]
  if not port then
    print("No live server running for this directory.")
    return
  end
  vim.fn.jobstart({ "pkill", "-f", "live-server.*" .. port }, {
    on_exit = function()
      print("Stopped live server on port " .. port)
      live_servers[dir] = nil
    end,
  })
end, opts)
