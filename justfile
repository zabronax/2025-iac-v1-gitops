default:
    @just --list

[group('infra')]
infra command:
    # Injects decrypted secrets into terraform
    sops exec-env secrets/infrastructure.encoded.env 'terraform -chdir=infrastructure {{command}}'

[group('debug')]
connect username ipv4_address:
    #!/usr/bin/env sh
    # This creates a temporary file from the decrypted content,
    # which gets passed to ssh as the identity
    # Once it is complete (ssh tunnel is closed) the file gets removed

    tmpkey=$(mktemp) # Create temporary file
    trap 'rm -f "$tmpkey"' EXIT # Ensure the file is delete once script is complete

    sops -d secrets/maintenance-key.encoded.id > "$tmpkey" # Write the decrypted content to the file
    chmod go-rwx "$tmpkey" # Lock down file permissions, necessary due to ssh's security stance
    ssh -i "$tmpkey" {{username}}@{{ipv4_address}} # Open tunnel

[group('secrets')]
rotate-dek:
    printf "Rotating data encryption keys"
