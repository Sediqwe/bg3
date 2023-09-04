class UsersController < ApplicationController
  before_action :authorized?, only: %i[new edit update destroy show index]
  def index
  end
end
