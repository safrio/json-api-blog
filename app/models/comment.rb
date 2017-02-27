# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :string           not null
#  post_id      :integer          not null
#  published_at :datetime
#  author_id    :integer
#

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User", validate: true

  validates :author, :post, :body, presence: true
end
