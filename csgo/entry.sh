#! /bin/bash

# Set directory path
working_dir="${WORKINGDIR}"
steamcmd_dir=${STEAMCMDDIR}
server_dir="${STEAMAPPDIR}"
csgo_dir="${server_dir}/csgo"
server_installed_lock_file="${server_dir}/installed.lock"


start() {
    echo '> Starting server ...'

    additionalParams=""

    # Verify that CSGO_GSLT Token is set
    if [ -n "$CSGO_GSLT" ]; then
      additionalParams=" +sv_setsteamaccount $CSGO_GSLT"
    else
        echo '> Warning: Environment variable "CSGO_GSLT" is not set, but is required to run the server on the internet. Running the server in LAN mode instead.'
        additionalParams+=" +sv_lan 1"
    fi

    # Settings up password
    if [ -n "$CSGO_PASSWORD" ]; then
      additionalParams+=" +sv_password $CSGO_PASSWORD"
    fi

    # Settings up server name
    if [ -n "$CSGO_HOSTNAME" ]; then
      additionalParams+=" +hostname $CSGO_HOSTNAME"
    fi

    # Settings up API Key
    if [ -n "$CSGO_WS_API_KEY" ]; then
        additionalParams+=" -authkey $CSGO_WS_API_KEY"
    fi

    #  Force network setting
    if [ "${CSGO_FORCE_NETSETTINGS-"false"}" = "true" ]; then
        additionalParams+=" +sv_minrate 786432 +sv_mincmdrate 128 +sv_minupdaterate 128"
    fi

    # Settings up GOTV
    if [ "${CSGO_TV_ENABLE-"false"}" = "true" ]; then
        additionalParams+=" +tv_enable 1"
        additionalParams+=" +tv_delaymapchange ${CSGO_TV_DELAYMAPCHANGE-1}"
        additionalParams+=" +tv_delay ${CSGO_TV_DELAY-45}"
        additionalParams+=" +tv_deltacache ${CSGO_TV_DELTACACHE-2}"
        additionalParams+=" +tv_dispatchmode ${CSGO_TV_DISPATCHMODE-1}"
        additionalParams+=" +tv_maxclients ${CSGO_TV_MAXCLIENTS-10}"
        additionalParams+=" +tv_maxrate ${CSGO_TV_MAXRATE-0}"
        additionalParams+=" +tv_overridemaster ${CSGO_TV_OVERRIDEMASTER-0}"
        additionalParams+=" +tv_snapshotrate ${CSGO_TV_SNAPSHOTRATE-128}"
        additionalParams+=" +tv_timeout ${CSGO_TV_TIMEOUT-60}"
        additionalParams+=" +tv_transmitall ${CSGO_TV_TRANSMITALL-1}"

        if [ -n "${CSGO_TV_NAME}" ]; then
        additionalParams+=" +tv_name ${CSGO_TV_NAME}"
        fi

        if [ -n "${CSGO_TV_PORT}" ]; then
        additionalParams+=" +tv_port ${CSGO_TV_PORT}"
        fi

        if [ -n "${CSGO_TV_PASSWORD}" ]; then
        additionalParams+=" +tv_password ${CSGO_TV_PASSWORD}"
        fi
    fi

  set -x

  exec $server_dir/srcds_run \
    -game csgo \
    -console \
    -norestart \
    -usercon \
    -nobreakpad \
    +ip "${CSGO_IP-0.0.0.0}" \
    -port "${CSGO_PORT-27015}" \
    -tickrate "${CSGO_TICKRATE-128}" \
    -maxplayers_override "${CSGO_MAX_PLAYERS-8}" \
    +game_type "${CSGO_GAME_TYPE-0}" \
    +game_mode "${CSGO_GAME_MODE-1}" \
    +mapgroup "${CSGO_MAP_GROUP-mg_active}" \
    +map "${CSGO_MAP-de_dust2}" \
    +rcon_password "${CSGO_RCON_PW-changeme}" \
    $additionalParams \
    $CSGO_PARAMS
}

install() {
  echo '> Installing server ...'

  set -x

  $steamcmd_dir/steamcmd.sh \
    +force_install_dir $server_dir \
    +login anonymous \
    +app_update 740 validate \
    +quit

  set +x

  echo '> Done'

  touch $server_installed_lock_file
}

update() {
  echo '> Checking for server update ...'

  set -x

  $steamcmd_dir/steamcmd.sh \
    +login anonymous \
    +force_install_dir $server_dir \
    +app_update 740 \
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