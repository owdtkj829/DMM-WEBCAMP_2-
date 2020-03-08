class FavoritesController < ApplicationController
	before_action :set_book
	def create
		@favorite = Favorite.create(user_id: current_user.id, book_id: @book.id,book_id: @booker.id)
		@favorite.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id,book_id: @booker.id)
		@favorite.destroy
		redirect_back(fallback_location: root_path)
	end

	private
  def set_book
    @book = Book.find(params[:book_id])
    @booker = Book.find(params[:book_id])
  end
end
