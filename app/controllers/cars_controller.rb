class CarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_car, only: [:show, :edit, :update, :park]

  # GET /cars
  def index
    @cars = current_user.cars
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.user = current_user

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /cars/1/park
  def park
    if @car.parking_requests.not.discharged.count == 0 && @car.parking_requests.build(status: ParkingRequest::STATUSES[:requested]).save
      redirect_to root_path, notice: 'Parking request was made successfully.'
    else
      redirect_to cars_path, alert: "#{@car.errors.full_messages.join(', ')}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:registration_number, :model, :color)
    end
end
