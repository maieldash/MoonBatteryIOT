class MoonBatteriesController < ApplicationController
  before_action :authorize_request, except: [ :register ]

  def register
    moon_battery = MoonBattery.new(moon_battery_params)
    if moon_battery.save
      render_success(serial_number: moon_battery.serial_number, status: :created)
    else
      render json: { errors: moon_battery.errors }, status: :unprocessable_entity
    end
  end

  def ping
    moon_battery = find_moon_battery
    return render_error("MoonBattery not found", :not_found) unless moon_battery

    moon_battery.ping!
    render_success("Pinged successfully")
  end

  def configure
    moon_battery = find_moon_battery
    return render_error("MoonBattery not found", :not_found) unless moon_battery

    configurations = params[:moon_battery][:configurations]
    return render_error("Configurations must be an array of key-value pairs") unless configurations.is_a?(Array)

    errors = validate_and_update_configurations(moon_battery, configurations)

    if errors.any?
      render json: { errors: errors }, status: :bad_request
    else
      if moon_battery.save
        render_success("Configurations updated successfully")
      else
        render json: { errors: moon_battery.errors }, status: :unprocessable_entity
      end
    end
  end

  private


  def validate_and_update_configurations(moon_battery, configurations)
    errors = []
    configurations.each do |config|
      config = config.to_unsafe_h
      unless config.size == 1
        errors << "Each configuration must be a key-value pair. Found: #{config.inspect}"
        next
      end

      key, value = config.first
      errors.concat(validate_and_set_attribute(moon_battery, key, value))
    end
    errors
  end

  def validate_and_set_attribute(moon_battery, key, value)
    errors = []
    case key.downcase
    when "temperature"
      if valid_temperature?(value)
        moon_battery.temperature = value
      else
        errors << "Invalid temperature value."
      end
    when "mode"
      if valid_mode?(value)
        moon_battery.mode = value
      else
        errors << "Invalid mode value."
      end
    when "power_limit"
      if valid_power_limit?(value)
        moon_battery.power_limit = value
      else
        errors << "Invalid power limit value."
      end
    when "connected_lunar_cell"
      if valid_lunar_cell?(value)
        moon_battery.connected_lunar_cell = LunarCell.find(value)
      else
        errors << "The specified lunar cell does not exist."
      end
    else
      errors << "#{key} is not a valid configuration."
    end
    errors
  end

  def valid_temperature?(value)
    value.is_a?(Integer) && value.between?(0, 100)
  end

  def valid_mode?(value)
    %w[eco normal].include?(value)
  end

  def valid_power_limit?(value)
    value.is_a?(Integer) && value.between?(0, 5000)
  end

  def valid_lunar_cell?(value)
    LunarCell.exists?(value)
  end

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
  def render_error(message, status = :bad_request)
    render json: { error: message }, status: status
  end

  def render_success(message, status = :ok)
    render json: { message: message }, status: status
  end

end
