class SubsController < ApplicationController

  before_action :require_logged_in

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    #fail
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      @moderation = Moderation.new(moderator_id: current_user.id, sub_id: @sub.id)
      @moderation.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    return unless require_moderator?(@sub)
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
