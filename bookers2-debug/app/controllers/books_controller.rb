class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update,]

  def show
    @booker = Book.find(params[:id])
    @book = Book.new
    @books = Book.all
    @book_comment = BookComment.new
    @book_comments = BookComment.all
    if  @booker.user_id == current_user.id
        @user = current_user
    else
        @user = @booker.user
    end
  end

  def new
    @book = Book.new
  end

  def index
    @users =User.all
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash.now[:alert] = 'error'
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
        flash[:notice] = "successfully"
        redirect_to book_path(params[:id])
    else
        flash.now[:alert] = "error"
        render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
    if @user_or_book == "1"
      @users = User.search(params[:search], @user_or_book, @how_search)
    else
      @books = Book.search(params[:search], @user_or_book, @how_search)
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end
end
