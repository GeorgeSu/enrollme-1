# in spec/support/omniauth_macros.rb
module OmniauthMacros
  def mock_auth_hash(email)
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.

    
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      info: {
        email: email
      }
    })
  end
end