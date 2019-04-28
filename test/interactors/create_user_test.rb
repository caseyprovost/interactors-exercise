require "minitest/autorun"
require_relative "../../src/interactor_exercise"

class CreateUserSuccesfullyTest < Minitest::Test
  def setup
    @context = CreateUser.call(email: "john@example.com", password: "secret", name: "John Smith")
  end

  def test_that_user_record_is_created
    assert_equal true, @context.user.persisted?
  end
end

class CreateUserFailedTest < Minitest::Test
  def test_that_user_record_not_created
    user = Minitest::Mock.new
    user.expect :save, false

    User.stub(:new, user) do
      @context = CreateUser.call(email: "john@example.com", password: "secret", name: "John Smith")
      assert @context.user.nil?
      assert_equal "Could not save user", @context.message
    end
  end
end
