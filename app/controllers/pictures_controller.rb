class PicturesController < ApplicationController
  before_filter :current_user

  def create
    @current_user = User.find(session[:user_id])
    @picture = @current_user.build_picture(picture_params)

    if @picture.save
      redirect_to dashboard_path
    else
      flash.now[:alert] = "We had a little trouble uploading your photo: "
    end
  end

  def destroy

  end

  private
  def picture_params
    params.require(:picture).permit(:image)
  end
end
