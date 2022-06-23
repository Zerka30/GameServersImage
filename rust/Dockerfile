FROM scouthosting/steamcmd

LABEL maintainer="contact@zerka.dev"

ENV STEAMAPP rust
ENV STEAMAPPDIR "${WORKINGDIR}/${STEAMAPP}-dedicated"

EXPOSE 28015

WORKDIR ${STEAMAPPDIR}

COPY ./entry.sh ./

ENTRYPOINT ["./entry.sh" ]