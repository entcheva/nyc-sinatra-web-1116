class LandmarksController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/landmarks/new' do
    erb (:'landmarks/new')
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params['id'])
    erb (:'landmarks/edit')
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params['id'])
    erb (:'landmarks/show')
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params['id'])
    @landmark.update(params[:landmark])
    erb (:'landmarks/show')
  end

  get '/landmarks' do
    erb (:'landmarks/index')
  end

  post '/landmarks' do
    Landmark.create(params[:landmark])
    erb (:'landmarks/show')
  end

end
