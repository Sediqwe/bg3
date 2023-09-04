class StartController < ApplicationController
  def index
    @logok = Logola.all.last(10)
  end
end
