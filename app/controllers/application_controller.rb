class ApplicationController < ActionController::API

  def missing_params
    { error: "Missing/Malformed params"}
  end

  def unexpected_error
    {error: "Unexpected Error"}
  end


  rescue_from StandardError do |e|
    Rails.logger.error e.full_message
    render json: unexpected_error, status: 500
  end
end
