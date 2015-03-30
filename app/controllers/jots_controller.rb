class JotsController < ApplicationController

  def index
    #grab the jots according to session[:mode]]
    if current_user == nil
      redirect_to new_session_path
    end
    if params[:mode]
      session[:mode] = params[:mode]
    end

    if session[:mode] == 'friends'
      @jots = current_user.following_jots.order('created_at desc')
    elsif session[:mode] == 'near'
      @jots = []
      jot_list = Jot.all.order('created_at desc')
      jot_list.each do |jot|

        if jot.geocoded? && jot.latitude != nil
          if jot.distance_from([params[:latitude],params[:longitude]]) < 5

            @jots << jot
          end
        end
      end
    else
      @jots = Jot.all.order('created_at desc')

    end
    @jot = Jot.new

  end

  def show
    @jot = Jot.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @jot}
    end

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


    ExtractLatLngJob.perform_later(@jot)
    JotMailer.send_jot_to_followers(@jot).deliver_later
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
    params.require(:jot).permit(:text,:photo,:latitude,:longitude).merge(user_id: current_user.id)
  end






end
