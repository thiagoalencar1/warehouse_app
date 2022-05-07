class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params

    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.save

    if @warehouse.save
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Todos campos devem ser preenchidos.'
      render :new
    end
  end

  def edit; end

  def update
    warehouse_params

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso.'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash[:alert] = 'Atualização não realizada. Verifique os campos em vermelho.'
      render :edit
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: 'Galpão excluído com sucesso.'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(
      :name, :code, :city, :description, :address, :cep, :area
    )
  end
end
