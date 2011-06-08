class Twitterie
  ApiError = Class.new(Exception)

  def self.access_token
    @@access_tocken ||= begin
      consumer = OAuth::Consumer.new(AppConfig['twitter']['consumer_key'], AppConfig['twitter']['consumer_secret'],
                                     { :site => "http://api.twitter.com",
                                       :scheme => :header
                                     })
      # now create the access token object from passed values
      token_hash = {
        :oauth_token => AppConfig['twitter']['oauth_token'],
        :oauth_token_secret => AppConfig['twitter']['oauth_token_secret']
      }
      OAuth::AccessToken.from_hash(consumer, token_hash)
    end
  end


  def self.request(method, api_call, params = {}, headers = {})
    access_token.request(method, "http://api.twitter.com/1/#{api_call}.json", params, headers)
  end


  def self.process(*args)
    response = request(*args).tap{ |r| raise ApiError.new(r.body) unless r.code == "200" }
    ActiveSupport::JSON.decode response.body
  end


  def self.post_direct_message(to, msg)
    process(:post, "direct_messages/new", { :user => to, :text => msg })
  end


  def self.update_status(twit)
    process(:post, "statuses/update", { :status => twit })
  end

  def self.destroy(twit_id)
    process(:post, "statuses/destroy/#{twit_id}")
  end

  def self.timeline
    process(:get, "statuses/home_timeline")
  end

end
