class ApplicationController < ActionController::API
  def authorize_request
    token = request.headers["Authorization"]&.split(" ")&.last
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base)
      @token_battery = MoonBattery.find(decoded_token[0]["battery_id"])
      render json: { error: "Battery not found" }, status: :unauthorized unless @token_battery
      @requested_battery = MoonBattery.find_by(mac_address: params[:moon_battery][:mac_address])
      render json: { error: "Invalid token" }, status: :unauthorized unless @token_battery == @requested_battery
    rescue JWT::ExpiredSignature
      render json: { error: "Token has expired. Please log in again." }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
