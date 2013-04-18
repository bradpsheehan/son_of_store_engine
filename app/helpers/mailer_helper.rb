module MailerHelper
  def role_link(role, store_id)
    if role == 'admin'
      admin_manage_url(store_id, host: HOST_DOMAIN)
    elsif role == 'stocker'
      stock_products_url(store_id, host: HOST_DOMAIN)
    end
  end
end
