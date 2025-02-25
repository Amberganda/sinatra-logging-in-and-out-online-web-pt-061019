require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    # disable :show_exceptions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do

    @user = User.find_by(username: params[:username], password: params[:password])

    if @user
        session[:user_id] = @user.id
        redirect '/account'
    else
      erb :error
    end
  end
  
  #   rescue => exception
  #     pp exception
  #   end
  # end

  get '/account' do
    # @user = Helpers.current_user(session)
    erb :account
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end


end

