class ApplicationController < ActionController::Base
  def index
    response = JSON Net::HTTP.get('jsonplaceholder.typicode.com', '/todos/1')

    Rails.logger.info request.uuid

    Rails.logger.info response.to_json

    User.hello

    render json: response
  end

  def error
    params.raise_error
    render json: {}
  end

  def error_log
    params.raise_error

    render json: {}
  rescue StandardError => e
    Rails.logger.error e
    render json: {}
  end
end
