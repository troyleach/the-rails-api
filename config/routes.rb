Rails.application.routes.draw do
  scope 'api/v1' do
    resources :todos
    get '/sports/scores', to: 'sport_scores#index'
    get '/sports/schedule', to: 'sport_scores#schedule'
    get '/sports/teams', to: 'sport_scores#teams'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
