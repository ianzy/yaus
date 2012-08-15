require 'rubygems'
require 'oauth'

# make the consumer out of your secret and key
consumer_key = "Eo82fErKW17O6Ro5mHk3XLqWMex7zGMw2HzdUquu"
consumer_secret = "ZlwK53aWEZklAIvpzhxVegsHzCMFir1W0ZbdQxpn"
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