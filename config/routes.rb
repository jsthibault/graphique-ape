Rails.application.routes.draw do
  get 'graphiques/tech3'
  get 'graphiques/tech2' => 'graphiques#tech3'
  root 'graphiques#tech3'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
