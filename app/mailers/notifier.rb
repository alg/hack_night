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
      begin
        hacknight_approaching_notification(u).deliver
      rescue Twitterie::ApiError => e
        # just do nothing - most probably user is not following us
        # though I'd prefer to be able to add something like this
        #    Notification.new.to(u).saying("please follow us on twitter")
        # and show the user a Notification next time he visits us
      end

    end
  end

end
