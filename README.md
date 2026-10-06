# 🔀 Jumper

Jump between tmux sessions like never before.

One key opens a popup listing every tmux session, sorted by name with `main`
pinned to the top and the session you are in preselected. Type to filter,
press `Enter` to switch. Type a name no session matches and `Enter` creates
it and switches to it, so starting a new project is the same gesture as
returning to an old one. `Esc` closes the popup and changes nothing.

```
❯
  main
▶ archie
  breathe-ai
  hr/rails-upgrade-7-2
```

## 💽 Installation

To install using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm), add the following line to your `tmux.conf` file:

```bash
set -g @plugin "ikhurramraza/tmux-jumper"
```

Requires [`fzf`](https://github.com/junegunn/fzf).

## ⚙️ Options

To make it your own, set the following options in your `tmux.conf` file:

#### Key binding

Defines the keys to trigger the switcher popup window and whether to use tmux prefix. By default, the key is `C-\` (without the prefix).

```bash
set -g @jumper-key "Space"
set -g @jumper-key-without-prefix "false"
```

#### New-session script

Overrides the script run when the query matches no session. It receives the
query as its only argument. The default script creates the session if it does
not exist and switches to it; point this at your own launcher to set up
windows, worktrees or anything else a fresh session needs.

```bash
set -g @jumper-new-session-script "~/.local/scripts/my-tmux-switcher.sh"
```

#### Window dimensions

Defines the popup window properties like width, height and y position. The default values are:

```bash
set -g @jumper-popup-width 75
set -g @jumper-popup-height 10
set -g @jumper-popup-y-position 15
```

#### Title and border

Defines the title shown on the popup frame and its border style (any value
`popup-border-lines` accepts: `single`, `rounded`, `double`, `heavy`, `simple`,
`padded`, `none`). Both need tmux 3.3 or newer. The default values are:

```bash
set -g @jumper-popup-title " jumper "
set -g @jumper-popup-border "rounded"
```

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
