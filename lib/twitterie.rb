module Twitterie

  def access_token
    consumer = OAuth::Consumer.new(AppConfig['twitter']['consumer_key'], AppConfig['twitter']['consumer_secret'],
                                   { :site => "http://api.twitter.com",
                                     :scheme => :header
                                   })
    # now create the access token object from passed values
    token_hash = {
      :oauth_token => AppConfig['twitter']['oauth_token'],
      :oauth_token_secret => AppConfig['twitter']['oauth_token_secret']
    }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    return access_token
  end

  def request(method, api_call, params = {}, headers = {})
    access_token.request(method, "http://api.twitter.com/1/#{api_call}.json", params, headers)
  end


  def post_direct_message(to, msg)
    request(:post, "direct_messages/new", { :user => to, :text => msg })
  end


  def update_status(twit)
    request(:post, "statuses/update", { :status => twit })
  end

  def destroy(twit_id)
    request(:post, "statuses/destroy/#{twit_id}")
  end

  def timeline
    ActiveSupport::JSON.decode request(:get, "statuses/home_timeline").body
  end

end
