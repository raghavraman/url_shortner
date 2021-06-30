Rails.application.routes.draw do
  defaults format: :json do
    post 'shortern', to: 'web#shortern', as: :shortern
    get '/:key', to: 'web#redirect', as: :redirect
    delete '/:key', to: 'web#delete', as: :delete
  end
end
