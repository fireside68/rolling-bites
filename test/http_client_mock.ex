defmodule RollingBitesWeb.HTTPClientMock do
  use Mox
  # This line is specifying that this mock will implement the RollingBites.HTTPClient behaviour.
  impl RollingBitesWeb.HTTPClient
end
