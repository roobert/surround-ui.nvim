# Surround UI

Hinting for [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround.nvim)
using [folke/which-key.nvim](https://github.com/folke/which-key.nvim).

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
