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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
