export def style [] {
  let palette = source "nord.nuon"

  {
    text: {
      color: {
        light: $palette.nord4
        dark: $palette.nord0
      }
    }
    updates: {
      color: $palette.nord14
    }
    cpu: {
      color: $palette.nord7
    }
    mem: {
      color: $palette.nord7
    }
    wlan: {
      color: $palette.nord8
    }
    brightness: {
      color: $palette.nord12
    }
    volume: {
      color: $palette.nord15
    }
    battery: {
      color: {
        "critical": $palette.nord11
        "low": $palette.nord13
        "high": $palette.nord14
      }
    }
    date: {
      color: {
        icon: $palette.nord10,
        text: $palette.nord9,
      }
    }
    time: {
      color: {
        icon: $palette.nord10,
        text: $palette.nord9,
      }
    }
  }
}
