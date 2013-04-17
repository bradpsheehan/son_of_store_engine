class RoleConfirmationEmailJob
  @queue = :email

  def self.perform(user_id, store_id, role)
    user  = User.find(user_id)
    store = Store.find(store_id)
    Mailer.role_confirmation(user, store, role).deliver
  end
end