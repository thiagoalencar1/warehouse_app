class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show]

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
    @supplier = Supplier.new(supplier_params)

    @supplier.save

    if @supplier.save
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Todos campos devem ser preenchidos corretamente. '
      render :new
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :corporate_name, :brand_name, :nif, :full_address, :city, :state, :email, :contact_number
    )
  end
end
