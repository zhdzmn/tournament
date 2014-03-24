class CompetentsController < ApplicationController
  # GET /competents
  # GET /competents.json
  def index
    @competents = Competent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competents }
    end
  end

  # GET /competents/1
  # GET /competents/1.json
  def show
    @competent = Competent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competent }
    end
  end

  # GET /competents/new
  # GET /competents/new.json
  def new
    @competent = Competent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competent }
    end
  end

  # GET /competents/1/edit
  def edit
    @competent = Competent.find(params[:id])
  end

  # POST /competents
  # POST /competents.json
  def create
    @competent = Competent.new(params[:competent])

    respond_to do |format|
      if @competent.save
        format.html { redirect_to @competent, notice: 'Competent was successfully created.' }
        format.json { render json: @competent, status: :created, location: @competent }
      else
        format.html { render action: "new" }
        format.json { render json: @competent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /competents/1
  # PUT /competents/1.json
  def update
    @competent = Competent.find(params[:id])

    respond_to do |format|
      if @competent.update_attributes(params[:competent])
        format.html { redirect_to @competent, notice: 'Competent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @competent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competents/1
  # DELETE /competents/1.json
  def destroy
    @competent = Competent.find(params[:id])
    @competent.destroy

    respond_to do |format|
      format.html { redirect_to competents_url }
      format.json { head :no_content }
    end
  end
end
