defmodule MattVanHorn.Accounts do
  use Ash.Domain, otp_app: :matt_van_horn, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource(MattVanHorn.Accounts.Token)
    resource(MattVanHorn.Accounts.User)
  end
end
