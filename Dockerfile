FROM cdale77/docker-elixir-base:laest

# Set the port and env
ENV PORT=4001
ENV MIX_ENV=prod

# Set up app directory
RUN mkdir /var/app
WORKDIR /var/app

# Copy the source and compile
COPY . .
RUN mix compile
RUN mix release

# Run the server
CMD ["bin/drs_mock", "foreground"]

EXPOSE 4001
