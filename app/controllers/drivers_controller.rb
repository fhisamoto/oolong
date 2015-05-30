class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :destroy, :status]
  before_action :set_bounds, only: :in_area

  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.all
    render json: @drivers
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    render :json => @driver, :serializer => DriverSerializer
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(driver_params.permit(:name))

    if @driver.save
      render json: @driver, status: :created, location: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    if @driver.update(driver_params.permit(:latitude, :longitude, :driver_available))
      head :no_content
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    head :no_content
  end

  def in_area
    @drivers = Driver.are_available.in_bounds(@bounds)
    render json: @drivers
  end

  private

  def set_driver
    @driver = Driver.find(params[:id])
  end

  def driver_params
    if params[:driver]
      params[:driver].merge!(:driver_available => params[:driver][:driverAvailable])
    end
    params[:driver]
  end

  def set_bounds
    begin
      @bounds = [ parse_lat_lng(params[:sw]), parse_lat_lng(params[:ne]) ]
    rescue
      head :unprocessable_entity
    end
  end

  def parse_lat_lng(str_coords)
    coords = str_coords.split(',').map { |s| BigDecimal.new(s) }
    raise "malformed coordinate" if coords.size != 2
    Geokit::LatLng.new(*coords)
  end
end
