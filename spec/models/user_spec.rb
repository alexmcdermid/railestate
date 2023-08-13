require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create a valid user" do
    user = build(:user)
    expect(user).to be_valid
  end

  # Add more tests as required, for example:
  # it "should not create a user with invalid email" do
  #   user = build(:user, email: "notanemail")
  #   expect(user).not_to be_valid
  # end

  # also test using fixtures in rspec
  it "should be valid" do
    user = users(:one)
    assert user.valid?
  end
end