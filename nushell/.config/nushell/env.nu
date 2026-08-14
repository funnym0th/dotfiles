$env.PATH = [
    "/home/moth/.local/bin"
    "/home/moth/bin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
]

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
