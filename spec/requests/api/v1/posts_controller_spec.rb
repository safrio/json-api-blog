require 'rails_helper'

describe Api::V1::PostsController, type: :request do

  let(:user_hash) do
    {
      email:    'test@test.email',
      password: 'password',
      nickname: 'nickname'
    }
  end

  let(:new_user) { User.create(user_hash) }

  let(:post_hash) do
    {
      title:    'Test title',
      body:     'Test body',
      author_id: new_user.id
    }
  end

  it "Create the post" do
    post_with_token api_v1_posts_path, post_hash

    json = JSON.parse(response.body)

    expect(json['title']).to eq post_hash[:title]
    expect(json['body']).to  eq post_hash[:body]
  end

  let(:new_post) { Post.last }

  it "Show the post" do
    get_with_token "/api/v1/posts/#{new_post.id}.json"

    json = JSON.parse(response.body)

    expect(json['title']).to eq new_post[:title]
    expect(json['body']).to  eq new_post[:body]
  end

  it "Index of posts" do
    Post.create(post_hash)

    get_with_token api_v1_posts_path, { page: 1, per_page: 2 }

    json = JSON.parse(response.body)

    expect(json.count).to eq 2
  end

end