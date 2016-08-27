get '/users/new' do #new user registration form
  erb :'/users/new'
end

post '/users' do #registration form submission
  user = User.new(params[:user])
  if user.save && password_match?
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    @errors.push("passwords must match") unless password_match?
    erb :'/users/new'
  end
end

get '/login' do #user login form
  erb :'/users/index'
end

post '/login' do #user login submission
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = ['invalid credentials']
    erb :'/users/index'
  end
end

post '/logout' do #user logout
  session[:user_id] = nil
  redirect '/'
end
