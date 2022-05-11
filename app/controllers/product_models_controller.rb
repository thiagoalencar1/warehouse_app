class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show]
  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params

    @product_model = ProductModel.new(product_model_params)
    @product_model.save

    if @product_model.save
      redirect_to product_models_path, notice: 'Modelo de Produto cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Todos campos devem ser preenchidos corretamente.'
      render :new
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(
      :name, :weight, :width, :height, :depth, :sku, :supplier_id
    )
  end
end
