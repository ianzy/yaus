require 'rubygems'
require 'oauth'

# make the consumer out of your secret and key
consumer_key = "1rdC3EcM3qvKY8uPIeEU3h8KDGIXh9hjaDUoNv3f"
consumer_secret = "mXUXZrvT2y4VW7Q86Vf0sP8uTZLfaBIVOeDBjVR7"
consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                               :site => "http://localhost:3000",
                               :request_token_path => "/oauth/request_token",
                               :authorize_path => "/oauth/authorize",
                               :access_token_path => "/oauth/access_token",
                               :http_method => :get)

# make the access token from your consumer
access_token = OAuth::AccessToken.new consumer

# make a signed request!
res = access_token.post("/api/urls.json", '{"url":{"url":"http://www.paypal.com"}}', { 'Accept'=>'application/json', 'Content-Type' => 'application/json' })

p res.body