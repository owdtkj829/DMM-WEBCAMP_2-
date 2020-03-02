class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update,]

  def show
  	@booker = Book.find(params[:id])
    @book = Book.new
    @user = current_user
    if @booker.user_id == current_user.id
       @user = current_user
    else
       @user = @booker.user
    end
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
    if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		render :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(params[:id]), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
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
