json.array! @notifications do |notification|
  json.user notification.user_id
  json.action notification.action
  json.read_at notification.read_at
  json.notification notification.notificationable_type
  json.transaction notification.trans
  

end