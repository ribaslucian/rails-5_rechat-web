class Voluntary::UsersController < Voluntary::VoluntaryController

  def logout
    session[:user] = nil
    redirect_to '/guest/users/login'
  end
end
