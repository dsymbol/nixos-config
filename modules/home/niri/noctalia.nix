{ ... }:

{
  xdg.configFile."noctalia/config.toml".text = ''
    [bar.default]
    center = [ "media", "clock" ]
    end = [ "tray", "notifications", "clipboard", "network", "bluetooth", "volume", "brightness", "battery", "session" ]
    margin_edge = 8
    margin_ends = 8
    position = "bottom"
    scale = 1.10
    start = [ "launcher", "workspaces" ]

    [desktop_widgets]
    enabled = false

    [notification]
    history_retention_hours = 24

    [shell]
    clipboard_auto_paste = "off"
    clipboard_confirm_clear_history = false
    clipboard_history_max_entries = 20
    font_family = "JetBrainsMono Nerd Font"
    polkit_agent = true
    settings_show_advanced = true
    telemetry_enabled = false

    [shell.launcher]
    categories = false
    fetch_exchange_rates = false

    [shell.panel]
    open_near_click_control_center = true
    open_near_click_session = true

    [shell.screenshot]
    save_to_file = false

    [shell.session]
    grid_columns = 1
    show_shortcuts = false

    [theme]
    builtin = "Tokyo-Night"
    mode = "dark"
    source = "builtin"

    [theme.templates]
    builtin_ids = [ "gtk3", "gtk4", "qt" ]
    enable_community_templates = false

    [idle.behavior.lock-and-suspend]
    action = "lock_and_suspend"
    enabled = true
    timeout = 900.0

    [idle.behavior.screen-off]
    action = "screen_off"
    enabled = true
    timeout = 600.0
    
    [widget.media]
    hide_when_no_media = true

    [widget.network]
    show_label = false

    [widget.volume]
    show_label = false
  '';
}
