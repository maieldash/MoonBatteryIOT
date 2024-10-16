  class LunarCellsController < ApplicationController
    before_action :authorize_request, except: [:register]

    def register
      lunar_cell = LunarCell.new(lunar_cell_params)
      if lunar_cell.save
        render_success(serial_number: lunar_cell.serial_number, status: :created)
      else
        render json: { errors: lunar_cell.errors }, status: :unprocessable_entity
      end
    end

    private
    def lunar_cell_params
      params.require(:lunar_cell).permit(:name, :serial_number, :location_id)
    end
    def render_success(message, status = :ok)
      render json: { message: message }, status: status
    end
  end
