class PlannedRunsController < ApplicationController
  before_action :set_planned_run, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:index, :show, :edit, :update, :destroy, :create, :new]
  helper_method :check_runs

  def index
    @planned_runs = @group.nil? ? PlannedRun.all : PlannedRun.where(group: @group).order(:date)
  end

  def show
  end

  def new
    @planned_run = PlannedRun.new
    @planned_run.group = @group
  end

  def edit
  end

  def create
    @planned_run = PlannedRun.new(planned_run_params)
    respond_to do |format|
      if @planned_run.save
        format.html { redirect_to @group, notice: 'Planned Run was successfully create. ' }
        format.json { render :show, status: :created, location: @planned_run }
      else
        format.html{ render :new }
        format.json { render json: @planned_run.errors, status: :unprocessable_entity }
      end
    end

    #Add all "Planned_runs" for runners in this new group. (Planned_runs turn into runs)
    Runner.where(group_id: @planned_run[:group_id]).find_each do |runner|
      run = Run.new
      run.runner = runner
      run.date = @planned_run.date
      run.training_plan = @planned_run.training_plan
      run.planned_run = @planned_run
      run.save
    end
  end


  def update
    respond_to do |format|
      if @planned_run.update(planned_run_params)
        format.html { redirect_to group_planned_run_path(@group, @planned_run), notice: 'Planned Run was successfully updated. '}
        format.json { render :show, status: :ok, location: @planned_run }
      else
        format.html { render :edit }
        format.json { render json: @planned_run.errors, status: :unprocessable_entity }
      end
    end

    #Update all runs if Planned_run is changed
    Run.where(planned_run_id: @planned_run.id).find_each do |run|
      updateRun = true
      if params[:checks]
        params[:checks].each do |checks|
          if checks.to_s == run.id.to_s
            updateRun = false
          end


        end
      end
      if updateRun
        run.date = @planned_run.date
        run.training_plan = @planned_run.training_plan
        if run.changed_flag
          run.changed_flag = nil
        end
        run.save
      end
    end
  end

  def destroy
     @planned_run.destroy
     respond_to do |format|
       format.html { redirect_to group_planned_runs_url(@group), notice: 'Planned Run was successfully deleted. '}
       format.json { head :no_content }
     end
  end

  def check_runs
    customized_runs = Run.where(changed_flag: true, planned_run_id: @planned_run.id)
  end


  private
  def set_planned_run
    @planned_run = PlannedRun.find(params[:id])
  end
  def set_group
    @group = Group.find(params[:group_id])
  end  

  def planned_run_params
    params.require(:planned_run).permit(:date, :group_id, :training_plan, :progress, :stuff)
  end

  def get_checks
   # @checks = [:checks]
  end
end