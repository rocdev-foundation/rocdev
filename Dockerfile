FROM vborja/asdf-alpine
USER root
RUN apk update && \
    apk upgrade && \
    apk add --no-cache musl-dev musl && \
    echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk add --no-cache \
      pcre@edge \
      ca-certificates \
      openssl-dev \
      ncurses-dev \
      unixodbc-dev \
      zlib-dev && \
    apk add --no-cache --virtual \
      .erlang-build \
      git autoconf build-base perl-dev

USER asdf
RUN asdf plugin-add erlang && \
    asdf plugin-add elixir && \
    asdf plugin-add nodejs && \
    asdf plugin-add python && \
    asdf plugin-add terraform && \
    asdf plugin-list
# USER root
# RUN bash .asdf/toolset/erlang/build-deps
# USER asdf
# RUN asdf-install-toolset erlang && \
#     asdf-install-toolset elixir && \
#     asdf-install-toolset nodejs && \
#     asdf-install-toolset python && \
#     asdf-install-toolset terraform
COPY . /asdf/app
WORKDIR /asdf/app
RUN cat .tool-versions && asdf install
RUN ./precheck
