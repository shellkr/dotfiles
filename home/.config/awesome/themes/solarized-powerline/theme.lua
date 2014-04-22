-- {{{
-- solarized powerline
-- }}}

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"


theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/solarized-powerline"
theme.wallpaper                     = theme.confdir .. "/wallpapers/zionello.jpg"

theme.font                          = "Tamsyn 8"
theme.taglist_font                  = "Icons 8"
theme.font_alt                      = "-misc-tamsyn-medium-r-normal--12-87-100-100-c-60-iso8859-1"
theme.bg_normal                     = base03
theme.bg_focus                      = base03
theme.bg_urgent                     = base03
theme.bg_special                    = base1
theme.fg_normal                     = base1
theme.fg_focus                      = base1
theme.fg_urgent                     = red
theme.fg_minimize                   = base3
theme.border_width                  = "1"
theme.border_normal                 = base02
theme.border_focus                  = base01
theme.border_marked                 = blue
theme.taglist_fg_focus              = base3
theme.taglist_bg_focus              = base02
theme.tasklist_fg_focus             = base1
theme.menu_width                    = "110"
theme.menu_border_width             = "0"
theme.menu_fg_normal                = base1
theme.menu_fg_focus                 = base3
theme.menu_bg_normal                = base02
theme.menu_bg_focus                 = base01

theme.menu_submenu_icon             = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                   = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                 = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                = theme.confdir .. "/icons/dish.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"
theme.widget_wifi                   = theme.confdir .. "/icons/wifi.png"
theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                   = theme.confdir .. "/icons/mail.png"
theme.widget_ac                     = theme.confdir .. "/icons/ac.png"
theme.widget_bat                    = theme.confdir .. "/icons/bat.png"
theme.widget_bat_med                = theme.confdir .. "/icons/bat_med.png"
theme.widget_bat_half               = theme.confdir .. "/icons/bat_half.png"
theme.widget_bat_low                = theme.confdir .. "/icons/bat_low.png"
theme.widget_bat_empty              = theme.confdir .. "/icons/battery_empty.png"
theme.widget_clock                  = theme.confdir .. "/icons/clock.png"
theme.widget_vol                    = theme.confdir .. "/icons/vol.png"
theme.widget_vol_med                = theme.confdir .. "/icons/vol-med.png"
theme.widget_vol_low                = theme.confdir .. "/icons/vol-low.png"
theme.widget_vol_no                 = theme.confdir .. "/icons/vol-no.png"
theme.widget_vol_mute               = theme.confdir .. "/icons/vol-mute.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/sel.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/unsel.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.layout_floating               = theme.confdir .. "/icons/floating.png"
theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
theme.layout_tileleft               = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.confdir .. "/icons/dwindle.png"

theme.arrl                          = theme.confdir .. "/icons/arrl.png"
theme.arrr                          = theme.confdir .. "/icons/arrr.png"
theme.arr0                          = theme.confdir .. "/icons/arr0.png"
theme.arr1                          = theme.confdir .. "/icons/arr1.png"
theme.arr2                          = theme.confdir .. "/icons/arr2.png"
theme.arr3                          = theme.confdir .. "/icons/arr3.png"

-- lain related
theme.useless_gap_width             = 5
theme.layout_uselesstile            = theme.confdir .. "/icons/uselesstile.png"

return theme
