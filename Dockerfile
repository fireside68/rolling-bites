# ---- Build Stage ----
FROM elixir:1.14 as builder

# Install build dependencies
RUN apt-get update && \
    apt-get install -y build-essential npm git python3 && \
    rm -rf /var/lib/apt/lists/*

# Prepare build directory
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set build ENV
ENV MIX_ENV=prod

# Install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# Build assets
COPY assets assets
RUN cd assets && \
    npm install && \
    npm run deploy
COPY priv priv
RUN mix phx.digest

# Compile the project
COPY lib lib
RUN mix do compile, release

# ---- Application Stage ----
FROM alpine:3.14 AS app

RUN apk --no-cache add openssl ncurses-libs libstdc++

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/rolling_bites ./

ENV HOME=/app

# Set production environment
ENV MIX_ENV=prod
ENV PORT=4000
ENV PHX_SERVER=true

# This should be changed to your own domain/host
ENV PHX_HOST=localhost

CMD ["bin/rolling_bites", "start"]
