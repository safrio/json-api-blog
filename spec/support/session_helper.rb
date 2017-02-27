module SessionHelper
  def retrieve_access_token
    post auth_user_path({email: 'safrio@gmail.com', password: 'ghb4elf'})

    expect(response.response_code).to eq 200
    expect(response.body).to match(/"auth_token":"[^\"]+"/)
    token = response.body.match(/"auth_token":"([^\"]+)"/)
    token[1]
  end
end