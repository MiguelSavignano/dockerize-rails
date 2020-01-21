class ApplicationController < ActionController::Base
  def index
    response = JSON Net::HTTP.get('jsonplaceholder.typicode.com', '/todos/1')

    Rails.logger.info "Test stackdriver logging"
    # Rails.logger.info response
    Rails.logger.info response.to_json

    render json: response
  end

  def landing
  end
end
