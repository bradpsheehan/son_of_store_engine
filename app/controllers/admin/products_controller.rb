class Admin::ProductsController < ApplicationController
  before_filter :require_admin_or_stocker
  before_filter :find_product, only: [ :edit,
                                       :update,
                                       :destroy,
                                       :toggle_status ]

  def index
    @products = current_store.products.order('created_at DESC')
                             .page(params[:page]).per(20)
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_store.products.new(params[:product])
    if @product.save
      redirect_to admin_product_path,
        :notice => "Successfully created product."
    else
      render :action => 'new', :notice  => "Product creation failed."
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to admin_product_path,
        :notice  => "Successfully updated product."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_product_path,
      :notice => "Successfully destroyed product."
  end

  def toggle_status
    if @product.toggle_status
      redirect_to admin_product_path,
        :notice  => "Product status successfully set to '#{@product.status}'."
    else
      head 400
    end
  end

  private
  def find_product
    @product = current_store.products.find(params[:id])
  end
end
