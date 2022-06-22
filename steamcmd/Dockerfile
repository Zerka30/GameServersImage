FROM scouthosting/base:bullseye

LABEL maintainer="contact@zerka.dev"
ARG USERID=1001

ENV USER steam
ENV WORKINGDIR "/steam"
ENV STEAMCMDDIR "${WORKINGDIR}/steamcmd"

RUN set -x \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    lib32stdc++6=10.2.1-6 \
    lib32gcc-s1=10.2.1-6 \
    ca-certificates=20210119 \
    locales=2.31-13+deb11u3 \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && useradd -u "${USERID}" -m "${USER}" \
    && mkdir -p "${WORKINGDIR}" \
    && mkdir -p "${STEAMCMDDIR}" \
    && chown -R "${USER}" "${WORKINGDIR}" \
    && su "${USER}" -c \
    "wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
    && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
    && mkdir -p \"${WORKINGDIR}/.steam/sdk32\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${WORKINGDIR}/.steam/sdk32/steamclient.so\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
    && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
    # Symlink steamclient.so; So misconfigured dedicated servers can find it
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    # Clean up
    && apt-get remove --purge --auto-remove -y \
    wget \
    && rm -rf /var/lib/apt/lists/*