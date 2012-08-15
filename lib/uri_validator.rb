require 'net/http'

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    raise(ArgumentError, "A regular expression must be supplied as the :format option of the options hash") unless options[:format].nil? or options[:format].is_a?(Regexp)
    configuration = { :message => "is invalid or not responding", :format => URI::regexp(%w(http https)) }
    configuration.update(options)
    
    if value =~ configuration[:format]
      begin # check header response
        uri = URI.parse(value)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if value =~ /^https/
        case http.head(uri.request_uri)
        when Net::HTTPOK then true
        when Net::HTTPFound then true
        when Net::HTTPMovedPermanently then true
        else object.errors.add(attribute, configuration[:message]) and false
        end
      rescue # Recover on DNS failures..
        object.errors.add(attribute, configuration[:message]) and false
      end
    else
      object.errors.add(attribute, configuration[:message]) and false
    end
  end
end