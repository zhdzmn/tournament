class ResultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_resources
  
  # GET /results
  # GET /results.json
  def index
    @results = @fixture.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
    @result = @fixture.results.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @result }
    end
  end

  # GET /results/new
  # GET /results/new.json
  def new
    @result = @fixture.results.new
    @result.match_number = @fixture.results.count + 1
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = @fixture.results.find(params[:id])
  end

  # POST /results
  # POST /results.json
  def create
    @result = @fixture.results.new(params[:result])
    
    respond_to do |format|
      if @result.save
        format.html { redirect_to fixture_result_url(@fixture, @result), notice: 'Result was successfully created.' }
        format.json { render json: @result, status: :created, location: @result }
      else
        format.html { render action: "new" }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.json
  def update
    @result = @fixture.results.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to fixture_result_url(@fixture, @result), notice: 'Result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result = @fixture.results.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to fixture_results_url(@fixture) }
      format.json { head :no_content }
    end
  end

  private
  def load_resources
    @fixture = Fixture.find(params[:fixture_id])
    @competents = [@fixture.competent1, @fixture.competent2]
  end

end
