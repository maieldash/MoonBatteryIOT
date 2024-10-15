class AuthController < ApplicationController
  def login
    moon_battery = MoonBattery.find_by(mac_address: params[:mac_address])
    if moon_battery
      token = encode_token(moon_battery)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Battery not found. Please register first." }, status: :not_found
    end
  end
  private
  def encode_token(moon_battery)
    JWT.encode({ battery_id: moon_battery.id }, Rails.application.credentials.secret_key_base)
  end
end
