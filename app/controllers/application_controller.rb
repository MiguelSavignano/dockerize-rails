class ApplicationController < ActionController::Base
  def index
    response = JSON Net::HTTP.get('jsonplaceholder.typicode.com', '/todos/1')
    render json: response
  end
end
