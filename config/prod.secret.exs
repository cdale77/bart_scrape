use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :bart_scrape, BartScrape.Endpoint,
  secret_key_base: "3z4qECyOf8MwTvb6FzSWeifIgmP9qgiDh8a3k9JgkbzpuQEEvJ5G/VMQOufh3tUO"

# Configure your database
config :bart_scrape, BartScrape.Repo,
  adapter: Ecto.Adapters.Postgres,
  #username: System.get_env("DATABASE_USER"),
  #password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_URL"),
  pool_size: 15
