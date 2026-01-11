# wireman.nvim

Open **Wireman** in a floating terminal in Neovim.

> **Note:** You need to first install [Wireman](https://github.com/preiter93/wireman).  

## Configuration

- Lazy plugin manager:
```lua
{
  "preiter93/wireman.nvim",
  config = function()
    local wireman = require("wireman")
    wireman.setup({
      cmd = "wireman",
      float_opts = { border = "single", width = 0.9, height = 0.8 },
    })

    -- Optional keymap
    wireman.map("<leader>wm", "<cmd>lua require('wireman').toggle()<CR>")
  end
}
```

## Demo

![](https://raw.githubusercontent.com/preiter93/wireman.nvim/main/assets/demo.png?raw=true)
