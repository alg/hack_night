class TwitterDelivery
  require 'twitterie'

  def initialize(values)
  end

  def deliver!(mail)
    Twitterie.post_direct_message mail.to.first, mail.body.decoded
  end
end


class Notifier < ActionMailer::Base
  default :delivery_method => TwitterDelivery

  def hacknight_approaching_notification(user)
    @event = Event.get
    mail :to => user.nickname
  end


  # Note it's a class method as it's not actually using ActionMailer
  # delegating to #hacknight_approaching_notification
  #
  def self.emit_hacknight_approaching_notification!
    User.all.each do |u|
      hacknight_approaching_notification(u).deliver
    end
  end

end
