class RegisterUser
  include Interactor::Organizer

  organize CreateUser, RecordUserData, WelcomeNewUser
end
