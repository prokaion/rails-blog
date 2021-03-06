class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def autocomplete
    @users = User.order(:name).where("name LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @users.map(&:name)
      }
      puts format.to_s
    end
  end

  def check_for_duplicate_names
    puts params[:term]
    @user = User.find_by(name: params[:term])
    if( @user )
      render html: "<ul class='alert-color'><li>Name has already been taken</li></ul>".html_safe
    else
      render plain: ""
    end          
  end

	def index
		@users = User.paginate( page: params[:page]).where(activated: true) 
	end
	
	def show
		@user = User.find(params[:id])	
  
    #show only published articles if guest or not owner and not admin!
    if( logged_in? && @user == current_user || current_user.admin?)
      @articles = @user.articles.paginate(page: params[:page])
    else      
      @articles = @user.articles.paginate(page: params[:page]).where(published: true)
    end
	end

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
         render 'new'
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
	  def user_params
		  params.require( :user).permit(:name, :email, :password,
								      :password_confirmation)
	  end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
