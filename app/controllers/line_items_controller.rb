class LineItemsController < ApplicationController
  include CurrentCart

  skip_before_action :authorize, only: %i[create destroy]
  before_action :set_cart, only: %i[create destroy]
  before_action :set_line_item, only: %i[show edit update destroy]

  def index
    @line_items = LineItem.all
  end

  def show; end

  def new
    @line_item = LineItem.new
  end

  def edit; end

  def create
    build_line_item

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @line_item.quantity == 1
      @line_item.destroy
    else
      @line_item.update(quantity: @line_item.quantity - 1)
    end

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.js
      format.json { head :no_content }
    end
  end

  private

  def build_line_item
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id)
  end
end
