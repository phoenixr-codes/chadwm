#!/usr/bin/env nu

# NOTE: Updating this script triggers a reload such that "live ricing" is more
#       convenient. This way you don't have to restart dwm when tweaking around.

use ~/.config/nushell/xx.nu
use themes/nord.nu *

const intervals = [
  [subject,    interval];
  [time,       1sec]
  [updates,    5min]
  [wlan,       1sec]
  [volume,     1ms]
  [battery,    10sec]
  [brightness, 1ms]
  [memory,     30sec]
  [cpu,        30sec]
  [other,      1sec]
]
const reload_interval = 500ms

def fg [color: string] {
  $"^c($color)^"
}

def bg [color: string] {
  $"^b($color)^"
}

def reset [] {
  "^d^"
}

def cpu [] {
  let loadavg = (sys cpu | first | get load_average | split row ", " | first)
  $"[ (fg (style).text.color.dark)(bg (style).cpu.color)  (reset)(fg (style).text.color.light) ($loadavg)(reset) ]"
}

def updates [] {
  let updates_result = (timeout 20 checkupdates | complete)
  match $updates_result.exit_code {
    0 => {
      let updates = ($updates_result | get stdout | lines | length)
      $"[ (fg (style).updates.color) ($updates) updates(reset) ]"
    },
    1 | 124 => $"[ (fg (style).updates.color) Updates unknown(reset) ]",
    2 => $"[ (fg (style).updates.color) Fully Updated(reset) ]"
  }
}

def battery [] {
  let capacity = ((xx battery) * 100) | into int

  let display = match $capacity {
    100  => {icon: {normal: "󰁹", charging: "󰂅"}, color: (style).battery.color.high},
    90.. => {icon: {normal: "󰂂", charging: "󰂋"}, color: (style).battery.color.high},
    80.. => {icon: {normal: "󰂁", charging: "󰂊"}, color: (style).battery.color.high},
    70.. => {icon: {normal: "󰂀", charging: "󰢞"}, color: (style).battery.color.high},
    60.. => {icon: {normal: "󰁿", charging: "󰂉"}, color: (style).battery.color.high},
    50.. => {icon: {normal: "󰁾", charging: "󰢝"}, color: (style).battery.color.high},
    40.. => {icon: {normal: "󰁽", charging: "󰂈"}, color: (style).battery.color.high},
    30.. => {icon: {normal: "󰁼", charging: "󰂇"}, color: (style).battery.color.high},
    20.. => {icon: {normal: "󰁻", charging: "󰂆"}, color: (style).battery.color.low},
    10.. => {icon: {normal: "󰁺", charging: "󰢜"}, color: (style).battery.color.critical},
    _    => {icon: {normal: "󰂎", charging: "󰢟"}, color: (style).battery.color.critical},
  }

  let remaining_until_empty = (
    xx battery remaining-until-empty
      | into record
      | default 0 hour
      | default 0 minute
      | format pattern "{hour}h {minute}min"
  )

  let remaining_until_full = (
    xx battery remaining-until-full
      | into record
      | default 0 hour
      | default 0 minute
      | format pattern "{hour}h {minute}min"
  )

  $"[ (fg $display.color)(if (xx battery charging) { $display.icon.charging } else { $display.icon.normal }) ($capacity)%(reset)(fg (style).text.color.light) (if (xx battery charging) { $'($remaining_until_full) until full' } else { $'($remaining_until_empty) until empty' })(reset) ]"
}

def brightness [] {
  $"[ (fg (style).text.color.dark)(bg (style).brightness.color) 󰖨 (reset)(fg (style).text.color.light) ((xx brightness) * 100 | math round)%(reset) ]"
}

def volume [] {
  let volume = ((xx volume) * 100) | into int
  mut icon = ""
  if (xx volume muted) {
    $icon = " "
  } else if ($volume == 0) {
    $icon = " "
  } else if ($volume in 1..50) {
    $icon = " "
  } else {
    $icon = " "
  }
  $"[ (fg (style).text.color.dark)(bg (style).volume.color) ($icon)(reset)(fg (style).text.color.light) ($volume)%(reset) ]"
}

def mem [] {
  $"[ (fg (style).text.color.dark)(bg (style).mem.color)  (reset)(fg (style).text.color.light) ((sys mem).used)/((sys mem).total)(reset) ]"
}

def wlan [] {
	if (xx wlan connected) {
	  $"[ (fg (style).text.color.dark)(bg (style).wlan.color) 󰤨 (reset)(fg (style).text.color.light) (try { xx wlan ssid } catch { "Connected" })(reset) ]"
  } else {
	  $"[ (fg (style).text.color.dark)(bg (style).wlan.color) 󰤭 (reset)(fg (style).text.color.light) Disconnected(reset) ]"
  }
}

def clock [] {
  $"(fg (style).text.color.dark)(bg (style).time.color.icon) 󱑆 (fg (style).text.color.dark)(bg (style).time.color.text) (date now | format date '%H:%M') (reset)"
}

def datetime [] {
  $"(fg (style).text.color.dark)(bg (style).date.color.icon) 󰃭 (fg (style).text.color.dark)(bg (style).date.color.text) (date now | format date '%a, %d.%m') (reset)"
}

mut current_interval = 0ms
mut display = {
  time: "",
  datetime: "",
  battery: "",
  volume: "",
  wlan: "",
  brightness: "",
  updates: "",
  memory: "",
  cpu: "",
}
loop {
  let requires_update = {|current, subject|
    ($current mod (
      $intervals
      | where {|x| $x.subject == $subject}
      | first
      | get interval
      | append $reload_interval
      | math max
    )) == 0ms
  }
  if (do $requires_update $current_interval time) { $display.time = clock }
  if (do $requires_update $current_interval time) { $display.datetime = datetime }
  if (do $requires_update $current_interval battery) { $display.battery = battery }
  if (do $requires_update $current_interval volume) { $display.volume = volume }
  if (do $requires_update $current_interval wlan) { $display.wlan = wlan }
  if (do $requires_update $current_interval brightness) { $display.brightness = brightness }
  if (do $requires_update $current_interval updates) { $display.updates = updates }
  if (do $requires_update $current_interval memory) { $display.memory = mem }
  if (do $requires_update $current_interval cpu) { $display.cpu = cpu }
  let leading_space = "    " # some space is required otherwise the content is cut
  xsetroot -name $"($leading_space)($display.updates) ($display.cpu) ($display.memory) ($display.wlan) ($display.brightness) ($display.volume) ($display.battery) ($display.datetime) ($display.time)"
  sleep $reload_interval
  $current_interval += $reload_interval
}
