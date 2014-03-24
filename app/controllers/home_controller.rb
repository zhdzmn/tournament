class HomeController < ApplicationController
  # GET /fixtures
  # GET /fixtures.json
  def index
    @fixtures = Fixture.all
    respond_to do |format|
      format.html
    end
  end
end
