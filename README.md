# :hugs: Surround UI

![surround-ui demo](https://user-images.githubusercontent.com/226654/215343170-a2d9da04-0de2-4a9f-9eb2-72f136ebe9cf.gif)

A NeoVIM plugin which can be used as a training aid or leader-triggered replacement for
some of the key combinations when using
[kylechui/nvim-surround](https://github.com/kylechui/nvim-surround). 

This plugin uses [folke/which-key.nvim](https://github.com/folke/which-key.nvim).

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
