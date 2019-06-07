resources :projects, except: %i[new edit] do
  resources :tasks, except: %i[new edit], controller: 'tasks' do
    resources :comments, except: %i[new edit], controller: 'comments'
  end
end
