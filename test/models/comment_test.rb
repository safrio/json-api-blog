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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
