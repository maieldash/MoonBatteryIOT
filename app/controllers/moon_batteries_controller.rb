class MoonBatteriesController < ApplicationController
  before_action :authorize_request, except: [ :register ]
  def register
    moon_battery = MoonBattery.new(moon_battery_params)
    if moon_battery.save
      render json: { serial_number: moon_battery.serial_number }, status: :created
    else
      render json: moon_battery.errors, status: :unprocessable_entity
    end
  end

  def ping
    moon_battery = find_moon_battery
    if moon_battery
      moon_battery.ping!
      render json: "pinged successfully", status: :ok
    else
      render json: "MoonBattery not found", status: :not_found
    end
  end

  def configure
    moon_battery = find_moon_battery
    if moon_battery
      configurations = params[:moon_battery][:configurations]
      configurations.each do |config|
        config.each do |key, value|
          configuration = moon_battery.configurations.find_or_initialize_by(key: key)
          configuration.value = value
          configuration.save!
        end
      end
      render json: { message: "configurations updated successfully" }, status: :ok
    else
      render json: { error: "MoonBattery not found" }, status: :not_found
    end
  end

  private

  def moon_battery_params
    params.require(:moon_battery).permit(:mac_address, :charge_level, :connected_lunar_cell_id)
  end
  def find_moon_battery
    if params[:moon_battery][:mac_address]
      MoonBattery.find_by(mac_address: params[:moon_battery][:mac_address])
    elsif params[:moon_battery][:serial_number]
      MoonBattery.find_by(serial_number: params[:moon_battery][:serial_number])
    else
      nil
    end
  end
end
