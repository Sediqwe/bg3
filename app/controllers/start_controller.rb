class StartController < ApplicationController
  def index
    @logok = Logola.all.order(id: :DESC).first(10)
  end
end
