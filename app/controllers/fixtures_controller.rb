class FixturesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  
  # GET /fixtures
  # GET /fixtures.json
  def index
    @fixtures = Fixture.order('match_date ASC, match_time ASC')
    @fixtures = @fixtures.group_by(&:mode)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fixtures }
    end
  end

  # GET /fixtures/1
  # GET /fixtures/1.json
  def show
    @fixture = Fixture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fixture }
    end
  end

  # GET /fixtures/new
  # GET /fixtures/new.json
  def new
    @fixture = Fixture.new
    @group = Group.find(params[:group_id]) if params[:group_id].present?

    @groups = Group.order('mode DESC, name ASC')
    @groups = @groups.where(id: params[:group_id]) if params[:group_id].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fixture }
    end
  end

  # GET /fixtures/1/edit
  def edit
    @fixture = Fixture.find(params[:id])
    @groups = Group.order('mode DESC, name ASC')
  end

  # POST /fixtures
  # POST /fixtures.json
  def create
    @fixture = Fixture.new(params[:fixture])
    @groups = Group.order('mode DESC, name ASC')

    respond_to do |format|
      if @fixture.save
        format.html { redirect_to @fixture, notice: 'Fixture was successfully created.' }
        format.json { render json: @fixture, status: :created, location: @fixture }
      else
        format.html { render action: "new" }
        format.json { render json: @fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fixtures/1
  # PUT /fixtures/1.json
  def update
    @fixture = Fixture.find(params[:id])
    @groups = Group.order('mode DESC, name ASC')

    respond_to do |format|
      if @fixture.update_attributes(params[:fixture])
        format.html { redirect_to @fixture, notice: 'Fixture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixtures/1
  # DELETE /fixtures/1.json
  def destroy
    @fixture = Fixture.find(params[:id])
    @fixture.destroy

    respond_to do |format|
      format.html { redirect_to fixtures_url }
      format.json { head :no_content }
    end
  end
end
