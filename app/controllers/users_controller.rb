class UsersController < Clearance::UsersController

  def new
    @user = User.new
    render "users/new"
  end

  def listings
  end

  def create
    @user = user_from_params
    respond_to do |format|
      if @user.save
        sign_in @user
        format.js { redirect_back_or url_after_create }
      else
        format.html { render "users/new" }
        format.js
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to @user
  end

  private
  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end

  def user_from_params
    name = user_params.delete(:name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    user = User.new
    user.name = name
    user.email = email
    user.password = password

    return user
  end
end