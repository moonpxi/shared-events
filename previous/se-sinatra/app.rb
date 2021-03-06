require 'rubygems'
require 'bundler'
Bundler.require

require_relative 'model'
require_relative 'helpers/date_formatter'
require_relative 'helpers/date_picker'

helpers DateFormatter, DatePicker do
  def require_user!
    @user = User.by_name(session['user'])
  end
end

configure do
  MongoMapper.database = 'shared-events-ruby'
  enable :sessions

  bootstrap_model  
end

# Viewing events

get '/' do
  redirect '/week' if session['user']
  redirect '/login'
end

get '/week' do
  redirect "/view?from=#{week_start.to_s}&to=#{week_end.to_s}"
end

get '/next' do
  redirect "/view?from=#{(week_end + 1).to_s}"
end

get '/view' do
  require_user!
  @period = [:from, :to].reduce({}) { |m, p| m.merge(p => parse_date(params[p])) }

  @events_per_day = Event.find_within_period_for(@user, @period).
                          group_by { |event| event.start_at.to_date }

  haml :view
end

# New

get '/new' do
  require_user!
  
  haml :new
end

post '/new' do
  usernames = params[:who].split(',').map { |name| name.strip }

  Event.create(:title => params[:what],
               :start_at => date_for(params[:when]),
               :participants => usernames.map { |name| User.by_name(name) })

  redirect '/week'
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
