class NotificationsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def index
    @notifications = current_user.notifications.unread
  end
  def mark_as_read
    @notifications = current_user.notifications.unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end
end