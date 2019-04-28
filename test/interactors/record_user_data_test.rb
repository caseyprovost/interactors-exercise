require "minitest/autorun"
require_relative "../../src/interactor_exercise"

class RecordUserDataSuccesfullyTest < Minitest::Test
  def setup
    @user = Minitest::Mock.new
    @user.expect :send_data_to_google, true
    @user.expect :send_data_to_amazon, true
    @user.expect :send_data_to_facebook, true
  end

  def test_that_user_data_is_sent_to_analytics_service
    User.stub(:new, @user) do
      context = RecordUserData.call(user: @user)
      assert_equal true, context.all_data_delivered
    end
  end
end

class RecordUserDataFailedTest < Minitest::Test
  def setup
    @user = Minitest::Mock.new
    @user.expect :send_data_to_google, true
    @user.expect :send_data_to_amazon, true
    @user.expect :send_data_to_facebook, false
  end

  def test_that_user_record_not_created
    User.stub(:new, @user) do
      context = RecordUserData.call(user: @user)
      assert_equal false, context.all_data_delivered
      assert_equal "Not all data was sent", context.message
    end
  end
end
