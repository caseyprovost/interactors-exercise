require "minitest/autorun"
require_relative "../../src/interactor_exercise"

class WelcomeNewUserSuccesfullyTest < Minitest::Test
  def setup
    @user = Minitest::Mock.new
    @user.expect(:send_welcome_email, true)
  end

  def test_that_welcome_email_is_sent
    User.stub(:new, @user) do
      context = WelcomeNewUser.call(user: @user)
      assert_nil context.message
    end
  end
end

class WelcomeNewUserFailedTest < Minitest::Test
  def setup
    @user = Minitest::Mock.new
    @user.expect(:send_welcome_email, false)
  end

  def test_that_welcome_email_failed_to_send
    User.stub(:new, @user) do
      context = WelcomeNewUser.call(user: @user)
      assert_equal "welcome email failed", context.message
    end
  end
end
