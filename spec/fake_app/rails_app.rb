# config
app = Class.new(Rails::Application)
app.config.secret_token = '964ab2f0fbbb68bc36f3cc487ca296bb8555fac50627924024c245a1599e5265'
app.config.session_store :cookie_store, key: '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false

# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :users
end

# controllers
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
