return {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    config = function()
        require("toggleterm").setup({
            direction = "float",
            start_in_insert = true,
            close_on_exit = true,
            float_opts = {
                border = "rounded",
            },
        })

        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end
    end,
}
