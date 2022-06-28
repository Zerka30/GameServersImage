FROM scouthosting/steamcmd

LABEL maintainer="contact@zerka.dev"

ENV STEAMAPP rust
ENV STEAMAPPDIR "${WORKINGDIR}/${STEAMAPP}-dedicated"

EXPOSE 28015

WORKDIR ${STEAMAPPDIR}

RUN chown -R steam:steam "${STEAMAPPDIR}"

COPY ./entry.sh ./

USER steam

ENTRYPOINT ["./entry.sh" ]