resources :projects, except: %i[new edit] do
  resources :tasks, except: %i[new edit], controller: 'tasks' do
    resources :comments, except: %i[new edit], controller: 'comments'
  end
end

post 'attachments/upload', to: AttachmentUploader.upload_endpoint(:cache)
