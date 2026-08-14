$env.config.buffer_editor = "zed"
$env.config.show_banner = false
$env.config.table.mode = 'rounded'
$env.config.datetime_format = {
    normal: '%d/%m/%Y %H:%M:%S'
}

alias chafa = chafa -f kitty --passthrough=tmux

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.STARSHIP_LOG = "error"

let current_date = (date now | format date "%d/%m/%Y")
let current_uptime = (sys host).uptime
let current_user = $env.USER

source $"($nu.cache-dir)/carapace.nu"

print $"($current_date), current uptime is ($current_uptime) and logged user is ($current_user)"
