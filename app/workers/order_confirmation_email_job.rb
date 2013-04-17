class  OrderConfirmationEmailJob
  @queue = :email

  def self.perform(name, email, order_id)
    order = Order.find(order_id)
    Mailer.order_confirmation(name, email, order).deliver
  end
end