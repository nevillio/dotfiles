import os
from urllib.request import urlopen

config.load_autoconfig()
c.content.blocking.method = "both"
c.tabs.show = "multiple"
c.auto_save.session = True
config.set("colors.webpage.darkmode.enabled", True)
config.set("zoom.default", 115)
config.set("qt.highdpi", True)
config.set(
    "url.searchengines",
    {
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "wa": "https://wiki.archlinux.org/?search={}",
        "yt": "https://www.youtube.com/results?search_query={}",
        "gh": "https://github.com/search?utf8=✓&q={}",
        "ghc": "https://github.com/search?utf8=✓&q={}&type=code",
        "mdn": "https://developer.mozilla.org/en-US/search?q={}",
        "dai": "https://duckduckgo.com/?q={}&ia=chat",
        "pai": "https://www.perplexity.ai/search/?q={}",
        "tribe": "https://jira.lgi.io/browse/TRIBE-{}",
        "arris": "https://jira.lgi.io/browse/ARRISEOS-{}",
    },
)
c.fonts.web.size.default = 16

# swap bindings for tabs
config.bind("J", "tab-prev")
config.bind("K", "tab-next")

# install theme
if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme

    theme.setup(c, "mocha", True)

config.bind(",m", "spawn ~/bin/umpv {url}")
config.bind(",M", "hint links spawn ~/bin/umpv {hint-url}")
config.bind(";M", "hint --rapid links spawn ~/bin/umpv {hint-url}")

# ======================= Redline Insert Mode ============= {{{
# Awesome way to open vim from qutebrowser
# c.editor.command = [
#     os.environ["TERMINAL"],
#     "-e",
#     os.environ["EDITOR"],
#     "-f",
#     "{file}",
#     "-c",
#     "normal {line}G{column0}1",
# ]

config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")
config.bind("<Ctrl-x><Ctrl-e>", "open-editor", "insert")
# }}}
