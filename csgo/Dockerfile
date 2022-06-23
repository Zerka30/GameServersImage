FROM scouthosting/steamcmd

LABEL maintainer="contact@zerka.dev"

ENV STEAMAPP csgo
ENV STEAMAPPDIR "${WORKINGDIR}/${STEAMAPP}-dedicated"

EXPOSE 27015

WORKDIR ${STEAMAPPDIR}

COPY ./entry.sh ./

ENTRYPOINT ["./entry.sh" ]