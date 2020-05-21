class ProductsController < ApplicationController
  load_and_authorize_resource
  # layout :render_layout
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favourite]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    # render template: 'products/test'
  end

  # GET /products/new
  def new
    @product = Product.new

    if params[:category_id]
      @product.category_id = params[:category_id]
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favourite
    if @product.users.where(id: current_user.id).count == 0
      current_user.favourite_products.create!(product_id: @product.id)
    else
      @product.favourite_products.where(user_id: current_user.id).destroy_all
    end

    respond_to do |format|
      format.html { redirect_to product_url(@product), notice: '' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:category_id, :name, :description, :price, color_ids: [])
    end

    def render_layout
      if action_name == 'show'
        'product_show'
      elsif action_name == 'edit'
        'product_edit'
      else
        'application'
      end
    end
end
