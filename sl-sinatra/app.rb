require 'rubygems'
require 'bundler'
Bundler.require

require_relative 'model'
require_relative 'helpers/date_formatter'
require_relative 'helpers/date_picker'

helpers DateFormatter, DatePicker

configure do
  MongoMapper.database = 'shared-events-ruby'
  enable :sessions

  bootstrap_model  
end

get '/' do
  redirect '/week' if session['user']
  redirect '/login'
end

get '/week' do
  @period = {:from => week_start, :to => week_end}

  @user = User.where(:name => session['user']).first
  @events_per_day = Event.find_within_period_for(@user, @period).
                          group_by { |event| event.start_at.to_date }.
                          sort

  haml :view
end

get '/next' do
  @period = {:from => week_end + 1}

  @user = User.where(:name => session['user']).first
  @events_per_day = Event.find_within_period_for(@user, @period).
                          group_by { |event| event.start_at.to_date }.
                          sort

  haml :view
end

get '/view' do
  @period = {:from => week_start, :to => week_end}

  @user = User.where(:name => session['user']).first
  @events_per_day = Event.find_within_period_for(@user, @period).
                          group_by { |event| event.start_at.to_date }.
                          sort

  haml :view
end

# Login/logout actions
get '/login' do
  @available_users = User.all

  haml :login
end

post '/login' do
  session['user'] = params[:login_as]
  redirect '/'
end

get '/logout' do
  session['user'] = nil
  redirect '/'
end

# Stylesheet link
get '/shared.css' do
   content_type 'text/css', :charset => 'utf-8'
   sass :shared
end
