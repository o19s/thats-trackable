class GrouptrainingplansController < ApplicationController
  before_action :set_grouptrainingplan, only: [:show, :edit, :update, :destroy]

  def index
    @grouptrainingplans = Grouptrainingplan.all
  end

  def show
  end

  def new
    @grouptrainingplan = Grouptrainingplan.new
  end

  def edit
  end

  def create
    @grouptrainingplan = Grouptrainingplan.new(grouptrainingplan_params)
    respond_to do |format|
      if @grouptrainingplan.save
        format.html { redirect_to @grouptrainingplan, notice: 'Group Training Plan was successfully create. ' }
        format.json { render :show, status: :created, location: @grouptrainingplan }
      else
        format.html{ render :new }
        format.json { render json: @grouptrainingplan.errors, status: :unprocessable_entity }
      end
    end

    #Will give all runners in given group this training program as individual training programs
    Runner.find_each do |running|
      if running.group_id.to_s == grouptrainingplan_params[:group_id]
        indPlan = Individualtrainingplan.new
        indPlan.runner_id = running.id
        indPlan.date = grouptrainingplan_params[:date]
        indPlan.trainingplan = grouptrainingplan_params[:trainingplan]
        groupLast = Grouptrainingplan.last
        indPlan.grouptrainingplans_id = groupLast.id
        indPlan.save
      end
    end

  end


  def update
    respond_to do |format|
      if @grouptrainingplan.update(grouptrainingplan_params)
        format.html { redirect_to @grouptrainingplan, notice: 'Group Training Plan was successfully updated. '}
        format.json { render :show, status: :ok, location: @grouptrainingplan }
      else
        format.html { render :edit }
        format.json { render json: @grouptrainingplan.errors, status: :unprocessable_entity }
      end
    end

    #Updates any given training plan
    #Loop through each existing individual plan
    Individualtrainingplan.find_each do |plan|
      oneGroup = Group.find(grouptrainingplan_params[:group_id])
      #Loop through each runner that is found in the given group
      oneGroup.runners.each do |run|
        if plan.date.to_s == grouptrainingplan_params[:date]
            plan.date = grouptrainingplan_params[:date]
            plan.trainingplan = grouptrainingplan_params[:trainingplan]
            plan.save
        end
      end
    end
  end

  def destroy
    currentGroup = Grouptrainingplan.find(params[:id])
    #Loop through and delete all Individual training plans with deleted grouptrainingplans_id
    Individualtrainingplan.all.each do |indPlan|
      if indPlan.grouptrainingplans_id.to_s == currentGroup.id.to_s
        indPlan.destroy
      end
    end

     @grouptrainingplan.destroy
     respond_to do |format|
       format.html { redirect_to grouptrainingplans_url, notice: 'Group Training Plan was successfully deleted. '}
       format.json { head :no_content }
     end
  end

  private
  def set_grouptrainingplan
    @grouptrainingplan = Grouptrainingplan.find(params[:id])
  end

  def grouptrainingplan_params
    params.require(:grouptrainingplan).permit(:date, :group_id, :trainingplan, :progress)
  end
end