class ParkingRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_parking_request, only: [:edit, :update, :destroy, :automate, :release, :discharge]

  # GET /parking_requests
  def index
    if current_user.admin?
      @parking_requests = ParkingRequest.all
    else
      @parking_requests = ParkingRequest.where(:car_id.in => current_user.cars.pluck(:_id))
    end
  end

  # GET /parking_requests/1/edit
  def edit
    @slots = Slot.not_in(:_id => ParkingRequest.not.discharged.pluck(:slot_id))
  end

  # PATCH/PUT /parking_requests/1
  def update
    if @parking_request.requested? && @parking_request.update(entry_on: Time.now, 
      slot_id: params[:parking_request][:slot_id], status: ParkingRequest::STATUSES[:allotted])
      message = { notice: 'Parking request was successfully updated.' }
    else
      message = { alert: "#{@parking_request.errors.full_messages.join(', ')}" }
    end
    redirect_to parking_requests_url, message
  end

  # POST /parking_requests/1/automate
  def automate
    slot_id = Slot.not_in(:_id => ParkingRequest.not.discharged.pluck(:slot_id)).sample.id

    if @parking_request.requested? && @parking_request.update(entry_on: Time.now, 
      slot_id: slot_id, status: ParkingRequest::STATUSES[:allotted])
      message = { notice: 'Parking request was successfully updated.' }
    else
      message = { alert: "#{@parking_request.errors.full_messages.join(', ')}" }
    end
    redirect_to parking_requests_url, message
  end

  # POST /parking_requests/1/release
  def release
    if @parking_request.allotted? && @parking_request.update(status: ParkingRequest::STATUSES[:release])
      message = { notice: 'Parking release request was successfully updated.' }
    else
      message = { alert: "#{@parking_request.errors.full_messages.join(', ')}" }
    end
    redirect_to parking_requests_url, message
  end

  # POST /parking_requests/1/discharge
  def discharge
    if @parking_request.release? && @parking_request.update(status: ParkingRequest::STATUSES[:discharged])
      message = { notice: 'Parking release request was successfully updated.' }
    else
      message = { alert: "#{@parking_request.errors.full_messages.join(', ')}" }
    end
    redirect_to parking_requests_url, message
  end

  # DELETE /parking_requests/1
  def destroy
    if @parking_request.requested? && @parking_request.destroy
      message = { notice: 'Parking request was successfully cancelled.' }
    else
      message = { alert: "Cannot be cancelled #{@parking_request.errors.full_messages.join(', ')}" }
    end
    redirect_to parking_requests_url, message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_request
      @parking_request = ParkingRequest.find(params[:id])
    end
end
