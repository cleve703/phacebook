class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.profile.nil?
      @profile = Profile.new
    else
      redirect_to profile_edit_path
    end
  end

  def edit
    @user = User.find_by(id: current_user.id)
    if @user.profile.blank?
      @profile = Profile.create(user_id: current_user.id)
    else  
      @profile = @user.profile
    end
  end

  def create
    @profile = Profile.new
    @profile.user_id = profile_params[:user_id]
    @profile.home_town = profile_params[:home_town]
    @profile.employer = profile_params[:employer]
    @profile.college = profile_params[:college]
    if @profile.save
      redirect_to user_profile_path(:id)
    else 
      redirect_to authenticated_root_path
    end
  end

  def update
    @profile = Profile.find_by(user_id: params[:user_id])
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(current_user.id)
    else
      render 'edit'
    end
  end

  def show
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def save
    @profile = Profile.new
    @profile.user_id = current_user.id
    @profile.save(profile_params)
    redirect_to user_profile_path(current_user.id)
  end

  private

    def profile_params
      profile_params = params.require(:profile).permit(:home_town, :employer, :college, :image)
    end

end
