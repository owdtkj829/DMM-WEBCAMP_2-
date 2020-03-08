class BookCommentsController < ApplicationController
	def create
	    @booker = Book.find(params[:book_id])
	    @book_comment = @booker.book_comments.build(comment_params)
	    @book_comment.user_id = current_user.id
	    if @book_comment.save
     		render :show
    	end
	end

	def destroy
		@book_comment = BookComment.find(params[:id]) 
    	if @book_comment.destroy
      		render :show
    	end
	end

	private
	def comment_params
	    params.require(:book_comment).permit(:comment, :book_id, :user_id)
	end
end
