class UsersController < ApplicationController
  before_action :authorized?, only: %i[new edit update destroy show index]
  def index
  end
  def sediqwe
    pityu = User.new(name: "sediqwe", password: Rails.application.credentials.pityu[:code], password_confirmation: Rails.application.credentials.pityu[:code])
    pityu.save
  end
end
