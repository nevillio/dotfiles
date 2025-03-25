config.load_autoconfig()
config.set("colors.webpage.darkmode.enabled", True)
config.set("zoom.default", 115)
config.set("qt.highdpi", True)
c.fonts.web.size.default = 16

config.bind("J", "tab-prev")
config.bind("K", "tab-next")
# config.bind(",m", spawn)
# c.fonts.tabs.selected = "20pt default_family"
# c.fonts.tabs.unselected = "20pt default_family"
