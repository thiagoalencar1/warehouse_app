class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: %i[show edit update delivered canceled]

  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(
      :warehouse_id, :supplier_id, :estimated_delivery_date
    )
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save!
    redirect_to @order, notice: 'Pedido registrado com sucesso.' if @order.save
  end

  def search
    @code = params['query']
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(
      :warehouse_id, :supplier_id, :estimated_delivery_date
    )
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end

  def delivered
    @order.delivered!
    redirect_to order_path(@order.id)
  end

  def canceled
    @order.canceled!
    redirect_to order_path(@order.id)
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    redirect_to root_path, notice: 'Você não tem permissão para acessar esse pedido' if @order.user != current_user
  end
end
