class User
  attr_reader :id
  attr_accessor :name
  attr_accessor :email
  attr_accessor :password

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def assign_attributes(attributes = {})
    attributes.each_pair do |attr, value|
      self.public_send("#{attr}=", value)
    end
  end

  def save
    @id ||= 123
    @persisted = true
    true
  end

  def persisted?
    !!@persisted
  end

  def send_data_to_google; true; end
  def send_data_to_facebook; true; end
  def send_data_to_amazon; true; end
  def send_welcome_email; true; end
end
