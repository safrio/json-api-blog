# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  body         :string           not null
#  published_at :datetime
#  author_id    :integer
#

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: "User", validate: true

  before_create :set_published_at

  validates :author, :title, :body, presence: true

  protected

  def set_published_at
    self.published_at ||= Time.current
  end
end
