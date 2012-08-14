class UrlsController < ApplicationController
  def index
    redirect_to root_path
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    @url = Url.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def show_short_url
    @url = Url.find_by_short_url(params[:short_url])
    if @url
      redirect_to @url.url
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /urls/new
  def new
    @url = Url.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # POST /urls
  # POST /urls.json
  def create
    
    url_match = params[:url][:url] =~ /\Ahttp(s?):\/\//i
    params[:url][:url] = "http://" << params[:url][:url] if url_match.nil?
    
    # find existing url
    @existing_url = Url.find_by_url(params[:url][:url])
    
    if @existing_url.nil?
      @url = Url.new(params[:url])
      id = Url.last.id unless Url.last.nil?
      @url.short_url = Shorten::Base62.to_s(id.nil? ? 1 : id+1)
      p @url
    else
      @url = @existing_url
    end

    respond_to do |format|
      if  !@existing_url.nil? or @url.save
        format.html { redirect_to @url, notice: 'Url was successfully shortened.' }
        format.json { render json: @url, status: :created, location: @url }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

end
