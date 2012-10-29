class Roswell::Application < Sinatra::Base

  before do
  end

  get '/' do
    erb :index
  end

end
