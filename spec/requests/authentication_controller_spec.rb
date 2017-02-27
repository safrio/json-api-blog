require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do

  let(:user_hash) do
    {
      email:    'test@test.email',
      password: 'password',
      nickname: 'nickname'
    }
  end

  it "Auth" do
    User.create(user_hash)

    post auth_user_path, user_hash

    json = JSON.parse(response.body)

    expect(json['auth_token']).to match(/^[^\"]+$/)
  end

end