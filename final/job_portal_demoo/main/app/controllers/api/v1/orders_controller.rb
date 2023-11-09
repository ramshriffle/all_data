class Api::V1::OrdersController < Api::V1::ApiController
  before_action :find_order, only: %i[show destroy]

  def index
    @orders = @current_user.orders
    output = {}
    output[:message] = "success"
    output[:data] = ActiveModelSerializers::SerializableResource.new(@orders, each_serializer: OrderSerializer)
    respond_to do |format|
      format.json { render status: :ok, json: output }
      format.html {  }
    end
  end

  def create
    if @current_user.cart.present?
      cart_items = @current_user.cart.cart_items
      order = order_now(cart_items)

      begin
        @current_user.cart.destroy
        output = {}
        output[:message] = "success"
        output[:message] = OrderSerializer.new order
        respond_to do |format|
          format.json { render json: output }
          format.html { redirect_to api_v1_order_order_items_path(order) }
        end
      rescue Exception => e
        render status: :internal_server_error, json: { message: e.message }
      end if order
    else
      render status: :not_found, json: { message: "Cart is empty" }
    end
  end

  def show
    output = {}
    output[:message] = "success"
    output[:data] = @order
    respond_to do |format|
      format.json { render json: output }
      format.html { redirect_to api_v1_order_order_items_path(@order) }
    end
  end

  def destroy
    @order.destroy
    render json: {message: 'Order deleted successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: {message: e.message}
  end

  def order_now(cart_items)
    ActiveRecord::Base.transaction do
      order = @current_user.orders.create
      cart_items.each do |item|
        order.order_items.create(
          restaurant_dish_id: item.restaurant_dish_id,
          quantity: item.quantity,
          price: item.price
        )
      end
      order
    end
  rescue Exception => e
    render json: {message: 'Oops. Order not placed'}
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:id])
    return if @order

    respond_to do |format|
      format.json { render status: :not_found, json: {message: 'Order not found'} }
      format.html { redirect_to "/not_found" }
    end

  end
end
