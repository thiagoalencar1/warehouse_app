class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params
      .require(:supplier)
      .permit(:corporate_name, :brand_name, :nif, :full_address, :city, :state))

    @supplier.save

    if @supplier.save
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Os seguintes campos devem ser preenchidos adequadamente.'
      render :new
    end
  end
end
