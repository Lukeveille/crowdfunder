require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_comment_needs_text
    comment = Comment.new(comment: '', project_id: Project.first)
    assert comment.invalid?, "Comments should not be able to be created without text in the body"
  end
end
