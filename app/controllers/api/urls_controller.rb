class Api::UrlsController < Api::BaseController

  # respond_to :json, :xml
  def create
    raise InvalidParameters if params[:url].nil?
    url_match = params[:url][:url] =~ /\Ahttp(s?):\/\//i
    params[:url][:url] = "http://" << params[:url][:url] if url_match.nil?
    
    @existing_url = Url.find_by_url(params[:url][:url])
    
    if @existing_url.nil?
      @url = Url.new(params[:url])
      id = Url.last.id unless Url.last.nil?
      @url.short_url = Shorten::Base62.to_s(id.nil? ? 1 : id+1)
    else
      @url = @existing_url
    end

    respond_to do |format|
      if !@existing_url.nil? or @url.save
        format.json { render json: @url, status: :created, location: @url }
      else
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

end
