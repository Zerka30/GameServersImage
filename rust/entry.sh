#! /bin/bash

# Set directory path
working_dir="${WORKINGDIR}"
steamcmd_dir=${STEAMCMDDIR}
server_dir="${STEAMAPPDIR}"
rust_dir="${server_dir}/rust"
server_installed_lock_file="${server_dir}/installed.lock"

start() {
    echo '> Starting server ...'

    additionalParams=""

    if [ -n "${RUST_HOSTNAME}" ]; then
        additionalParams+=" +hostname ${RUST_HOSTNAME}"
    fi

    if [ -n "${RUST_RCON_IP}" ]; then
        additionalParams+=" +rcon.ip ${RUST_RCON_IP}"
    fi

    if [ -n "${RUST_RCON_PORT}" ]; then
        additionalParams+=" +rcon.port ${RUST_RCON_PORT}"
    fi

    if [ -n "${RUST_RCON_WEB}" ]; then
        additionalParams+=" +rcon.web ${RUST_RCON_WEB}"
    fi

    if [ -n "${RUST_WORLDSIZE}" ]; then
        additionalParams+=" +server.worldsize ${RUST_WORLDSIZE}"
    fi

    if [ -n "${RUST_SEED}" ]; then
        additionalParams+=" +server.seed ${RUST_SEED}"
    fi

    if [ -n "${RUST_SAVEINTERVAL}" ]; then
        additionalParams+=" +server.saveinterval ${RUST_SAVEINTERVAL}"
    fi

    set -x

    exec $server_dir/RustDedicated \
        -batchmode \
        +server.ip "${RUST_IP-0.0.0.0}" \
        +server.port "${RUST_PORT-28015}" \
        +server.tickrate "${RUST_TICKRATE-10}" \
        +server.maxplayers "${RUST_MAXPLAYERS-32}" \
        +rcon.password "${RUST_RCON_PASSWORD-changeme}" \
        $additionalParams

}

# Install server
install() {
    echo '> Installing server ...'

    set -x

    $steamcmd_dir/steamcmd.sh \
    +force_install_dir $server_dir \
    +login anonymous \
    +app_update 258550 validate \
    +quit

    set +x

    echo '> Done'

    touch $server_installed_lock_file
}

# Update function if needed
update() {
    echo '> Checking for server update ...'

    set -x

    $steamcmd_dir/steamcmd.sh \
    +force_install_dir $server_dir \
    +login anonymous \
    +app_update 258550 \
    +quit

    set +x

    echo '> Done'
}

# Check if server is install or doesn't have update
install_or_update() {
    if [ -f "$server_installed_lock_file" ]; then
        update
    else
        install
    fi
}

# Run scripts using only one function or run normally
if [ ! -z $1 ]; then
    $1
else
    install_or_update
    start
fi