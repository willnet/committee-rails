app = Class.new(Rails::Application)
app.secrets.secret_key_base = '964ab2f0fbbb68bc36f3cc487ca296bb8555fac50627924024c245a1599e5265'
app.config.session_store :cookie_store, key: '_myapp_session'
app.config.eager_load = false
app.config.root = File.dirname(__FILE__)
app.initialize!

app.routes.draw do
  resources :users
end

class ApplicationController < ActionController::Base
end

class UsersController < ApplicationController
  def create
    render json: { id: 1, nickname: 'willnet' }
  end

  def update
    render json: { id: 1 }
  end
end
