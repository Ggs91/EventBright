module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
      when 'info' then 'alert-info'
      when 'success' then 'alert-success'
      when 'danger' then 'alert-danger'
      when 'warning' then 'alert-warning'
      when 'error' then 'alert-danger' #override stripe's "error" flash to work with bootstrap
      when 'notice' then 'alert-success' #override devise's "notice" flash to work with bootstrap
      when 'alert' then 'alert-danger' #override devise's "alert" flash to work with bootstrap
    end
  end
  #format price 
  def pretty_amount(amount_in_cents)
    amount_in_cents == 0 ? 'Free' : number_to_currency(amount_in_cents.to_f / 100, locale: :fr)
  end
end
