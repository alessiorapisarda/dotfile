return {
  {
    "jackMort/chatgpt.nvim",
    cmd = {
      "ChatGPT",
    },
    config = function()
      require("chatgpt").setup({
        -- your config
      })
    end,
  },
}
