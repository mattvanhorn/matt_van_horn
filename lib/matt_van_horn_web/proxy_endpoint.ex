defmodule MattVanHornWeb.ProxyEndpoint do
  use Beacon.ProxyEndpoint,
    otp_app: :matt_van_horn,
    session_options: Application.compile_env!(:matt_van_horn, :session_options),
    fallback: MattVanHornWeb.Endpoint
end
