#import "@preview/cram-snap:0.2.2": *
#import "@preview/keyle:0.2.0"

#let kbd = keyle.config()
#let cmd = "⌘"
#let enter = "⏎"

#set page(paper: "a4", flipped: true, margin: 1cm)
#set text(font: "Arial", size: 11pt)

#show: cram-snap.with(
  title: [Cheatsheet],
  subtitle: [Cheatsheet for dwm key shortcuts],
  icon: image("./dwm.png"),
  column-number: 2,
)

#table(
  theader(colspan: 2)[Applications],
  kbd(cmd, "c"), [Launch *Launcher*],
  kbd(cmd, "y"), [Launch *Yazi*],
  kbd(cmd, enter), [Launch *Terminal*],
  kbd(cmd, "."), [Launch *Emoji Picker*],
)

#table(
  theader(colspan: 2)[Toggles],
  kbd(cmd, "b"), [Toggle bar],
  kbd(cmd, "Ctrl", "t"), [Toggle gaps],
  kbd(cmd, "Shift", "Space"), [Toggle floating],
  kbd(cmd, "f"), [Toggle full screen],
)

#table(
  theader(colspan: 2)[Work spaces],
  kbd(cmd, "←"), [View left work space],
  kbd(cmd, "→"), [View right work space],
  kbd(cmd, "1-9"), [View work space at position],
  kbd(cmd, "Tab"), [Toggle view of work space],
)

#table(
  theader(colspan: 2)[Windows],
  kbd(cmd, "h"), [Move window more to the left],
  kbd(cmd, "l"), [Move window more to the right],
  kbd(cmd, "Shift", "j"), [Cycle windows forwards],
  kbd(cmd, "Shift", "k"), [Cycle windows backwards],
  kbd(cmd, "e"), [Hide window],
  kbd(cmd, "Shift", "e"), [Restore window],
  kbd(cmd, "Shift", "1-9"), [Move window to work space],
)

#table(
  theader(colspan: 2)[Gaps],
  kbd(cmd, "Ctrl", "i"), [Increase gaps],
  kbd(cmd, "Ctrl", "d"), [Decrease gaps],
  kbd(cmd, "Shift", "i"), [Increase inner gaps],
  kbd(cmd, "Ctrl", "Shift", "i"), [Decrease inner gaps],
  kbd(cmd, "Shift", "o"), [Increase outer gaps],
  kbd(cmd, "Ctrl", "Shift", "o"), [Decrease outer gaps],
  kbd(cmd, "Ctrl", "Shift", "d"), [Reset gaps],
)

#table(
  theader(colspan: 2)[Layout],
  kbd(cmd, "t"), [Tile],
  kbd(cmd, "Shift", "f"), [Monocle],
  kbd(cmd, "m"), [Spiral],
  kbd(cmd, "Ctrl", "g"), [Gapless grid],
  kbd(cmd, "Ctrl", "Shift", "t"), [Floating],
  kbd(cmd, "Space"), [Toggle layout],
  kbd(cmd, "Ctrl", ","), [Cycle layout backwards],
  kbd(cmd, "Ctrl", "."), [Cycle layout forwards],
)

#table(
  theader(colspan: 2)[Borders],
  kbd(cmd, "Shift", "-"), [Decrease border width],
  kbd(cmd, "Shift", "p"), [Increase border width],
  kbd(cmd, "Shift", "w"), [Reset border width],
)

#table(
  theader(colspan: 2)[Miscellaneous],
  kbd(cmd, "Ctrl", "q"), [Kill *dwm*],
  kbd(cmd, "Shift", "r"), [Reset *dwm*],
  kbd(cmd, "q"), [Kill window],
  kbd(cmd, "?"), [Show this Cheatsheet],
)

#table(
  theader(colspan: 2)[Functions],
  kbd("Fn", "Ctrl", "PrtScn"), [Take screenshot of entire screen],
  kbd("Fn", "PrtScn"), [Take screenshot of selected area],
  kbd("Fn", " "), [Log out],
  kbd("󰀝 "), [Toggle WiFi],
)
