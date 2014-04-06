class GroupsController < ApplicationController
  before_filter :authenticate_user!, except: [:standings]
  
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
    @groups = {'Singles' => {}, 'Doubles' => {}}
    @groups.each do |mode, groups|
      Group.where(mode: mode).each do |g|
        groups[g.name] = g.competents.collect do |c|
          {id: c.id, name: c.name, 
            match_played: g.fixtures.select {|f| (f.competent1_id == c.id || f.competent2_id == c.id) && f.match_begin }.size,
            point: g.results.where(winner_id: c.id).count, 
            ball_advantage: g.results.where(winner_id: c.id).sum(:ball_in_table)}
        end
        groups[g.name].sort! do |a, b|
          case
          when a[:point] < b[:point]
            1
          when a[:point] > b[:point]
            -1
          when a[:point] == b[:point]
            fixture = Competent.find(a[:id]).head_to_head(Competent.find(b[:id]))
            if fixture.nil?
              b[:ball_advantage] <=> a[:ball_advantage]
            else
              case
              when fixture.winner.try(:id) == a[:id]
                -1
              when fixture.winner.try(:id) == b[:id]
                1
              else
                b[:ball_advantage] <=> a[:ball_advantage]
              end
            end
          end
        end
      end
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
