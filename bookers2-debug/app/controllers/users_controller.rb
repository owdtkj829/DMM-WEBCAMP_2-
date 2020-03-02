class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update,]
  skip_before_action:logged_in_user,only:[:new,:create]

  def show
  	@book = Book.new
    @books = current_user.books
    @user = User.find(params[:id])
    @books = User.find(params[:id]).books
  end

  def index
    @user = current_user
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	if @user.update(user_params)
  		redirect_to user_path(params[:id]), notice: "successfully updated user!"
  	else
  		render :edit
  	end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end
    
    def logged_in_user
      unless logged_in?
        redirect_to user_session_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to user_session_path unless @user == current_user
    end

end
