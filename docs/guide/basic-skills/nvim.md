# Neovim

Did you know that hjkl is not vim?

## Installation

[环境配置指南/编辑器 – Neovim 安装配置教程（基于 NvChad）](https://zhuanlan.zhihu.com/p/712125953)

### issues

:::details [Background color different when running neovim inside tmux](https://github.com/wez/wezterm/issues/3649)

solved by:

in `~/.tmux.conf`

```txt
set-option -ga terminal-overrides ",xterm-256color:Tc"
```
in `~/.zshrc`

```txt
# alias
alias tmux="tmux -u"
```
:::

## Tricks

### Resources

[awesome-cheatsheets/editors/vim.txt](https://github.com/skywind3000/awesome-cheatsheets/blob/master/editors/vim.txt)

[Vim 有什么奇技淫巧？](https://www.zhihu.com/question/27478597/answer/2777381978)

### Notes

`gx` to open link.

see [How do I make these links open in Neovim?](https://www.reddit.com/r/neovim/comments/xv0f4q/how_do_i_make_these_links_open_in_neovim/)

[how to set tab spaces to 2](https://www.reddit.com/r/neovim/comments/vxqt95/how_to_set_tab_spaces_to_2/)

[tab space settings for markdown file](https://github.com/jiaau/nvim/blob/1b31b447532c6412ce14b358f5032012c2f94ccd/init.lua#L48)

### Search by line number

[current_buffer_fuzzy_find - options #1080](https://github.com/nvim-telescope/telescope.nvim/issues/1080)

[Sort results with equal score in the same file by their line number, especially current_buffer_fuzzy_find #1341](https://github.com/nvim-telescope/telescope.nvim/issues/1341)

[Added an opts parameter to be used when entry scores are tied #1401](https://github.com/nvim-telescope/telescope.nvim/pull/1401)
