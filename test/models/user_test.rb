require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid" do
    user = users(:one)
    assert user.valid?
  end

  # Additional tests as needed...
end
