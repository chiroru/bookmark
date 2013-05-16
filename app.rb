if development?
    require 'sinatra/reloader'
end

Sequel::Model.plugin(:schema)

Sequel.sqlite('db/diptych.db')
class Entries < Sequel::Model
  plugin :timestamps, :update_on_create => true
  unless table_exists?
    set_schema do
      primary_key :id
      string :url
      timestamp :created_at
      timestamp :updated_at
    end
    create_table
  end
end

get '/' do
  @title = 'diptych - TOP'
  @entries = Entries.all
  haml :index
end

post '/add' do
#  @url = params[:url]
#  Entries.insert :url => @url
  @entry = Entries.new :url => Sanitize.clean(@params[:url])
  @entry.save
  redirect '/'
end

helpers do
  def timefmt(time)
    if time
      time.strftime("%Y-%m-%d %H:%M:%S")
    else
      ''
    end
  end
end

