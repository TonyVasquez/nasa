# Nasa

Run project: 

- `./nasa iex -S mix run` 
- `./nasa mix test`

Docker:

- `docker run -it --rm --name nasa -v "$PWD":/usr/src/nasa -w /usr/src/nasa elixir iex -S mix` (repl)
- `docker run -it --rm --name nasa -v "$PWD":/usr/src/nasa -w /usr/src/nasa elixir mix test` (test)

