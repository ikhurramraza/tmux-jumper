# 🔀 Jumper

Jump between tmux session like never before.

```
TODO: add description
TODO: add screenshots
```

## 💽 Installation

To install using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm), add the following line to your `tmux.conf` file:

```bash
set -g @plugin "ikhurramraza/tmux-jumper"
```

## ⚙️ Options

To make it your own, set the following options in your `tmux.conf` file:

#### Key binding

Defines the keys to trigger the switcher popup window and whether to use tmux prefix. By default, the key is `C-\` (without the prefix).

```bash
set -g @jumper-key "Space"
set -g @jumper-key-without-prefix "false"
```

#### Executor script

Overrides the switch script. The script will be passed the session name. The default script creates the session (if it doesn't exist already) and switches to that session.

```bash
set -g @jumper-new-session-script "~/.local/scripts/my-tmux-switcher.sh"
```

#### Window dimensions

Defines the popup window properties like width, height and y position. The default values are:

```bash
set -g @jumper-popup-width 75
set -g @jumper-popup-height 10
set -g @jumper-popup-y-position 25
```

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
