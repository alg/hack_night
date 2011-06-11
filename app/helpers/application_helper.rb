module ApplicationHelper
  def decision_made?
    user_signed_in? && current_user.has_decided?
  end

  def admin?
    user_signed_in? && current_user.is_admin?
  end
end
