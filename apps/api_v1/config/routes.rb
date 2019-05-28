resources :projects, except: %i[new edit] do
  resources :tasks, except: %i[new edit], controller: 'tasks'
end
