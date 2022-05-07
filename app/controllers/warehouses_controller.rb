class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(
      :name, :code, :city, :description, :address, :cep, :area
    )
    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.save

    if @warehouse.save
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Todos campos devem ser preenchidos.'
      render :new
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])

    warehouse_params = params.require(:warehouse).permit(
      :name, :code, :city, :description, :address, :cep, :area
    )

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso.'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash[:alert] = 'Atualização não realizada. Verifique os campos em vermelho.'
      render :edit
    end
  end
end
