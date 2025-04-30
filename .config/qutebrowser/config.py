import os
from urllib.request import urlopen

from qutebrowser.api import interceptor

config.load_autoconfig()
config.set("colors.webpage.darkmode.enabled", True)
config.set("zoom.default", 115)
config.set("qt.highdpi", True)
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

config.bind(",m", "spawn umpv {url}")
config.bind(",M", "hint links spawn umpv {hint-url}")
config.bind(";M", "hint --rapid links spawn umpv {hint-url}")
# youtube add blocker
# def filter_yt(info):
#     """Block the given request if necessary."""
#     url = info.request_url
#     if (
#         url.host() == "www.youtube.com"
#         and url.path() == "/get_vide_info"
#         and "&adformat=" in url.query()
#     ):
#         info.block()
#
#
# interceptor.register(filter_yt)
