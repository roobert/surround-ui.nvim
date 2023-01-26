# Surround UI

Hinting for nvim-surround using which-key.

## :rocket: Installation

### Lazy.nvim

``` lua
{
  "roobert/surround-ui.nvim",
  dependencies = {
    "kylechui/nvim-surround",
    "folke/which-key.nvim",
  },
  config = function()
    require("surround-ui").setup({
      root_key = "S"
    })
  end,
}
```

### Packer.nvim

``` lua
use({
  "roobert/surround-ui.nvim",
  dependencies = {
    "kylechui/nvim-surround",
    "folke/which-key.nvim",
  },
  config = function()
    require("surround-ui").setup({
      root_key = "S"
    })
  end,
})
```
