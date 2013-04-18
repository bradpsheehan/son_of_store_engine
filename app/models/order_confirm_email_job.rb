class OrderConfirmEmailJob
  @queue = :email

  def self.perform(user, order_guid, order_total)
    Mailer.order_confirmation(user, order_guid, order_total).deliver
  end

end
