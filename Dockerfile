FROM cm2network/steamcmd

RUN mkdir "${HOMEDIR}/data"
RUN chown -R "${USER}:${USER}" "${HOMEDIR}/data"
VOLUME "${HOMEDIR}/data"

EXPOSE 2456-2457/udp

WORKDIR /valheim

RUN "${STEAMCMDDIR}/steamcmd.sh" \
  +force_install_dir /valheim \
  +login anonymous \
  +app_update 896660 validate \
  +quit

ENTRYPOINT ./valheim_server.x86_64 \
  -nographics \
  -batchmode \
  -public 0 \
  -port 2456 \
  -name "${SERVER_NAME:-Valheim}" \
  -password "${SERVER_PASSWORD:-Valheim}" \
  -world "${WORLD_NAME:-Valheim}" \
  -savedir "${HOMEDIR}/data"
