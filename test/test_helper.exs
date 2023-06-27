ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(RollingBites.Repo, :manual)
Mox.defmock(RollingBitesWeb.HTTPClientMock, for: HTTPoison.Base)
