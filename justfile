default:
    just --list

[group('debug')]
connect ipv4_address:
    #!/usr/bin/env sh
    tmpkey=$(mktemp)
    trap 'rm -f "$tmpkey"' EXIT

    sops -d infrastructure/maintenance-key.encoded.id > "$tmpkey"
    chmod 600 "$tmpkey"
    ssh -i "$tmpkey" root@{{ipv4_address}}

[group('secrets')]
rotate:
    printf "Rotating data encryption keys"
