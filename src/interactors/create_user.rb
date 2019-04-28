class CreateUser
  include Interactor

  def call
    user = User.new(
      email: context.email,
      password: context.password,
      name: context.name,
    )

    if user.save
      context.user = user
    else
      context.fail!(message: "Could not save user")
    end
  end
end
