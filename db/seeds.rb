# Generating 6 users, 30 posts and 150 comments

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

users_list = [
  [ "test", "email@example.com", "password"]
]

5.times do
  nickname = Faker::Name.first_name
  email = Faker::Internet.email(nickname)
  password = Faker::Internet.password(6)

  users_list << [ nickname, email, password ]
end

users_list.each do |nickname, email, password|
  # new User
  user = User.create!(
    nickname: nickname,
    email: email,
    password: password
  )

  5.times do
    title = Faker::Lorem.sentences(1)[0]
    body = Faker::Lorem.paragraph(3)
    published_at = time_rand
    # new Post
    post = user.posts.create!(
      title: title,
      body: body,
      published_at: published_at
    )

    5.times do
      comment_body = Faker::Lorem.paragraph(3)
      comment_published_at = time_rand(published_at)
      # new Comment
      post.comments.create!(
        author: user,
        body: comment_body,
        published_at: comment_published_at
      )
    end
  end

end