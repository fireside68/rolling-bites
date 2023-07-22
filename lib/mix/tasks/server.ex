defmodule Mix.Tasks.Server do
  use Mix.Task

  @shortdoc "Starts the Phoenix server with Dotenv"
  def run(_args) do
    Mix.Task.run("app.start", [])
    Mix.Task.run("phx.server", [])
  end
end
