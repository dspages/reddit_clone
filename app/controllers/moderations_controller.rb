class ModerationsController < ApplicationController

  def new
    @moderation = Moderation.new
    @subs=Sub.all
  end

  def create
    moderator = User.find_by_username(params[:moderation][:moderator_name])
    @moderation = Moderation.new(moderation_params)
    @moderation.moderator_id = moderator.id if moderator

    if @moderation.save
      redirect_to sub_url(@moderation.sub)
    else
      flash.now[:errors] = @moderation.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  private

  def moderation_params
    params.require(:moderation).permit(:moderator_id, :sub_id)
  end
end
