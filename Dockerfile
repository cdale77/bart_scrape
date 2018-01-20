FROM cdale77/docker-elixir-base:latest

# Set the port and env
ENV PORT=4001
ENV MIX_ENV=prod

# Set up app directory
RUN mkdir /var/app
WORKDIR /var/app

# Copy the source and compile
COPY . .
RUN mix deps.get
RUN mix compile
RUN mix release

# Run the server
CMD ["_build/prod/rel/bart_scrape/bin/bart_scrape", "foreground"]

#EXPOSE 4001
