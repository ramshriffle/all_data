class AddressesController < ApplicationController
  before_action :check_address_exists, only: [:show, :destroy, :update]
  
  def index
    @address=Address.all
    render json: @address
  end
  
  def show
    render json: @address 
  end
  
  def create
    address=Address.new(param_address)
    if address.save
      render json: address
    else
      render json: {errors: "Failed to create new address"}
    end
    # address=Address.create(param_address)
    # render json: address
  end
  
  def update
    @address.update(param_address)
    render json: @address
  end
  
  def destroy
    @address.destroy
    render json: @address
  end
  
  def param_address
    params.permit(:city,:addressible_id,:addressible_type)
  end
  
  def check_address_exists
    begin
      @address=Address.find(params[:id])
    rescue
      render json: "Address not found"
    end
  end
end
