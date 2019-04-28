require "minitest/autorun"
require "spy/integration"
require_relative "../../src/interactor_exercise"

class RegisterUserSuccessTest < Minitest::Test
  def setup
    @user = User.new(email: "foo@bar.com", name: "Some Dev")
    @user.save
    create_user_interactor = Spy.mock(CreateUser)
    Spy.on(create_user_interactor, :call).and_return(Interactor::Context.build(user: @user))

    record_user_data_interactor = Spy.mock(CreateUser)
    Spy.on(record_user_data_interactor, :call).and_return(Interactor::Context.build(user: @user, all_data_delivered: true))

    welcome_user_interactor = Spy.mock(CreateUser)
    Spy.on(welcome_user_interactor, :call).and_return(Interactor::Context.build(user: @user, all_data_delivered: true))
    @context = RegisterUser.call(email: "foo@bar.com", name: "Some Dev")
  end

  def test_that_user_is_registered
    assert_nil @context.message
    assert_equal true, @context.success?
  end

  def test_that_user_had_data_recorded
    assert_equal true, @context.google_data_delivered
    assert_equal true, @context.facebook_data_delivered
    assert_equal true, @context.amazon_data_delivered
  end

  def test_that_welcome_email_was_sent
    assert_equal true, @context.welcome_email_sent
  end
end

class RegisterUserFailureTest < Minitest::Test
  def setup
    @user = User.new(email: "foo@bar.com", name: "Some Dev")
    Spy.on_instance_method(User, :save).and_return(false)
    @context = RegisterUser.call(email: "foo@bar.com", name: "Some Dev")
  end

  def test_that_user_is_not_registered
    assert_equal false, @context.success?
  end
end
