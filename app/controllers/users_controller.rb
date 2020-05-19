class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :area, :password, :password_confirmation)
  end
end
