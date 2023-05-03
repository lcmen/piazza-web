require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "provides title for a specific page" do
    content_for(:title, "Home")

    assert_equal "Home | Piazza", title
  end

  test "provides default title" do
    assert_equal "Piazza", title
  end
end
