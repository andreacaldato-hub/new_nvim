return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>lg",
      function()
        local file = vim.fn.expand("%:p")
        if file == "" then
          print("No file detected!")
          return
        end

        local file_dir = vim.fn.fnamemodify(file, ":h")
        local git_root_tbl =
          vim.fn.systemlist("git -C " .. vim.fn.shellescape(file_dir) .. " rev-parse --show-toplevel")
        local git_root = nil
        if #git_root_tbl > 0 then
          git_root = git_root_tbl[1]
        end

        if type(git_root) ~= "string" or git_root == "" or vim.fn.isdirectory(git_root) == 0 then
          print("Not inside a valid Git repo!")
          return
        end

        -- Change Neovim's current working directory temporarily
        vim.cmd("lcd " .. git_root)

        -- Call the LazyGit command
        vim.cmd("LazyGit")
      end,
      desc = "LazyGit in current repo",
    },
  },
}
