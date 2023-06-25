class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user=User.find(params[:user_id])
      items=user.items
    else
       items = Item.all
    end
    render json: items, include: :user
  end
 def show
  item = Item.find_by(id: params[:id])
  render json: item, include: :user
 end

 def create
    user = User.find(params[:user_id])
    item=user.items.create!(item_params)
    if item
      render json: item, status: :created

    else
      render json: {error: item.errors.full_messages }, status: :unprocessable_entity
    end
 end
 private
 def item_params
  params.require(:item).permit(:name, :description, :price, :user_id)
 end

end


