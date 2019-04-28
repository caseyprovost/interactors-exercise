class RecordUserData
  include Interactor

  def call
    user = context.user
    send_data_to_google
    send_data_to_facebook
    send_data_to_amazon

    if all_data_delivered?
      context.all_data_delivered = true
    else
      context.all_data_delivered = false
      context.fail!(message: "Not all data was sent")
    end
  end

  private

  def all_data_delivered?
    context.google_data_delivered &&
      context.facebook_data_delivered &&
      context.amazon_data_delivered
  end

  def send_data_to_google
    context.google_data_delivered = context.user.send_data_to_google
  end

  def send_data_to_facebook
    context.facebook_data_delivered = context.user.send_data_to_facebook
  end

  def send_data_to_amazon
    context.amazon_data_delivered = context.user.send_data_to_amazon
  end
end
