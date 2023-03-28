class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find_by(id: params[:id])
    if toy
      toy.update(toy_params)
    else
      render_not_found_response
  end
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    if toy
    toy.destroy
    head :no_content
    else
      render_not_found_response
    end
  end

  # def increment_likes
  #   toy = Toy.find_by(id: params[:id])
  #   if toy
  #     toy.update (likes: toy.likes + 1)
  #     render json: toy
  #   else
  #     render json: {error: "Toy not found"}, status: :not_found
  #   end
  # end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_not_found_response
    render json: {error: "Toy not found"}, status: :not_found
  end

end