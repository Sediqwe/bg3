class StartController < ApplicationController
  def index
    @logok = Logola.all.order(id: :DESC).last(10)
  end
end
