class ApplicationController < ActionController::Base
  def index
    render json: { sucess: true }
  end
end
