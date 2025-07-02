export def style [] {
  let palette = source "catppuccin.nuon"

  {
    text: {
      color: {
        light: $palette.white
        dark: $palette.black
      }
    }
    updates: {
      color: $palette.green
    }
    cpu: {
      color: $palette.blue
    }
    mem: {
      color: $palette.blue
    }
    wlan: {
      color: $palette.sapphire
    }
    brightness: {
      color: $palette.peach
    }
    volume: {
      color: $palette.pink
    }
    battery: {
      color: {
        "critical": $palette.red
        "low": $palette.peach
        "high": $palette.green
      }
    }
    date: {
      color: {
        icon: $palette.flamingo,
        text: $palette.rosewater,
      }
    }
    time: {
      color: {
        icon: $palette.flamingo,
        text: $palette.rosewater,
      }
    }
  }
}
