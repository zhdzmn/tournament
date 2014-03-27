class GroupsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def standings
    @singles_groups = {}
    Group.where(mode: 'Singles').each do |g|
      @singles_groups[g.name] = g.competents.collect do |c|
        {name: c.name, win_count: c.results.count, ball_advantage: c.results.sum(:ball_in_table)}
      end
      @singles_groups[g.name].sort_by! {|a| a[:win_count]}.reverse!
    end
    @doubles_groups = {}
    Group.where(mode: 'Doubles').each do |g|
      @doubles_groups[g.name] = g.competents.collect do |c|
        {name: c.name, win_count: c.results.count, ball_advantage: c.results.sum(:ball_in_table)}
      end
      @doubles_groups[g.name].sort_by! {|a| a[:win_count]}.reverse!
    end

    respond_to do |format|
      format.html
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
