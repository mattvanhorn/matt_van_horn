defmodule MattVanHorn.Secrets do
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], MattVanHorn.Accounts.User, _opts) do
    Application.fetch_env(:matt_van_horn, :token_signing_secret)
  end
end
