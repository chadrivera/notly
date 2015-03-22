class JotsController < ApplicationController

  def index
    @jots = Jot.all.order('created_at desc')
    @jot = Jot.new

  end

  def show
    @jot = Jot.find(params[:id])

  end

  def new
  end

  def create
    # @jot = Jot.new
    # @jot.text = jots_params[:text]
    # @jot.save
    # TODO: Add error handling
    @jot = Jot.create(jots_params)
    #index photo
  #  ExtractLatLngJob.perform_later(@jot)
    redirect_to jots_path
  end

  def destroy
    @jot = Jot.find(params[:id])
    @jot.delete
    redirect_to jots_path
  end

  def edit
    @jot = Jot.find(params[:id])
  end

  def update
    @jot = Jot.find(params[:id])
    @jot.text = jots_params[:text]

    @jot.save
    #TODO: Add error handling
    redirect_to jots_path
  end

  def like
    # I really should check to see if that like exists first, but...
    @like = Like.create(user_id: current_user.id, jot_id: params[:jot_id])
    redirect_to jots_path
  end

  def unlike
    @like = Like.find_by_user_id_and_jot_id(current_user.id, params[:jot_id])
    @like.destroy
    redirect_to jots_path
  end

  def follows(subscriber, user)
    follow = Follower.find_by_user_id_and_subscriber_id(user.id,subscriber.id)
  end



  helper_method :follows
  private
  def jots_params
    params.require(:jot).permit(:text,:photo).merge(user_id: current_user.id)
  end






end
