FROM scouthosting/steamcmd

LABEL maintainer="contact@zerka.dev"

ENV STEAMAPP csgo
ENV STEAMAPPDIR "${WORKINGDIR}/${STEAMAPP}-dedicated"

EXPOSE 27015

WORKDIR ${STEAMAPPDIR}

RUN chown -R steam:steam "${STEAMAPPDIR}"

COPY ./entry.sh ./

USER steam

ENTRYPOINT ["./entry.sh" ]