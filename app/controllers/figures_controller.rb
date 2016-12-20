class FiguresController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/figures/new' do
    erb (:'figures/new')
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params['id'])
    erb (:'figures/edit')
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params['id'])
    erb (:'figures/show')
  end

  get '/figures' do
    erb (:'figures/index')
  end

  patch '/figures/:id' do
   if params[:figure][:name] != ""
     Figure.find_by_id(params[:id]).update(name: params[:figure][:name])
   end
   if params[:title][:name] != ""
     title = Title.create(name: params[:title])
     a = Figure.find_by_id(params[:id]).update(params[:figure])
     a.update(title_ids: title.id)
   end
   if params[:landmark][:name] != ""
     landmark = Landmark.create(name: params[:landmark])
     a = Figure.find_by_id(params[:id]).update(params[:figure])
     a.update(landmark_ids: landmark.id)
   end
    @figure = Figure.find_by_id(params['id'])
    erb (:'figures/show')
  end

  post '/figures' do #this needs refactoring/new logic
    if params[:title][:name] == "" && params[:landmark][:name] == ""
     Figure.create(params[:figure])
    elsif params[:title][:name] != "" && params[:landmark][:name] != ""
     Figure.create(params[:figure], params[:title], params[:landmark])
    elsif params[:title][:name] != ""
     title = Title.create(name: params[:title])
     a = Figure.create(params[:figure])
     a.update(title_ids: title.id)
    elsif params[:landmark][:name] != ""
     landmark = Landmark.create(name: params[:landmark])
     a = Figure.create(params[:figure])
     a.update(landmark_ids: landmark.id)
    end
    erb (:'/figures')
  end

end
