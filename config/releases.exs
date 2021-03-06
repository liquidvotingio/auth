import Config

db_user = System.fetch_env!("DB_USERNAME")
db_password = System.fetch_env!("DB_PASSWORD")
db_name = System.fetch_env!("DB_NAME")
db_host = System.fetch_env!("DB_HOST")
db_pool_size = System.get_env("DB_POOL_SIZE") || "10"

port = System.get_env("APP_PORT") || "4000"
secret_key_base = System.fetch_env!("SECRET_KEY_BASE")

config :liquid_voting_auth, LiquidVotingAuth.Repo,
  username: db_user,
  password: db_password,
  database: db_name,
  hostname: db_host,
  pool_size: String.to_integer(db_pool_size)

config :liquid_voting_auth, LiquidVotingAuthWeb.Endpoint,
  http: [:inet6, port: String.to_integer(port)],
  secret_key_base: secret_key_base

# to test the release:
# $ MIX_ENV=prod mix release
# $
# With database (not working yet)
# $
# $ SECRET_KEY_BASE=$(mix phx.gen.secret) \
# $ DB_USERNAME=postgres \
# $ DB_PASSWORD=postgres \
# $ DB_NAME=liquid_voting_auth_dev \
# $ DB_HOST=localhost \
# $ _build/prod/rel/liquid_voting_auth/bin/liquid_voting_auth start
