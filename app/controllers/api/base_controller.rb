class Api::BaseController < ApplicationController
  include OAuth::Controllers::ApplicationControllerMethods
  oauthenticate :strategies => :two_legged, :interactive => false
  
  class InvalidParameters < Exception ; end
  
  [
    {:klass => InvalidParameters, :status => 422, :errors => ['invalid parameters']},
    {:klass => ActiveRecord::RecordNotFound, :status => 404, :errors => ['not found']}
  ].each do |h|
    rescue_from h[:klass] do |e|
      render_errors_json(h[:errors], h[:status])
    end
  end
  
  protected  
  def render_errors_json(errors, status)
    render :json => {'errors' => errors.map{|x| {'error' => x}}}, :status => status
  end
end