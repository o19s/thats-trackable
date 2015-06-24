class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  before_action :get_runner


  def index
    if @runner
      @run = @runner.runs.order(:date)
    else
      @run = Run.all.order(:date)
    end

  end

  def show
  end



  def new
    @run = Run.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @run.update(run_params)
        if params[:commit] == 'Track Today'
          redirect_path = today_path
        else
          redirect_path = edit_runner_run_path(@runner,@run)
        end

        format.html { redirect_to redirect_path, notice: 'Run was successfully updated. '}
        format.json { render :show, status: :ok, location: @run }
      else
        if params[:commit] == 'Track Today'
          render_path = 'sessions/today'
        else
          render_path = 'runs/edit'
        end        
        format.html { render render_path }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @run = Run.new(run_params)
    @run.runner = @runner

    respond_to do |format|
      if @run.save
        format.html {redirect_to runner_runs_path(@runner), notice: 'Run was successfully created.' }
        format.json {render :show, status: :created, locations: @run }
      else
        format.html { render :edit }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @run.destroy
    respond_to do |format|
      format.html { redirect_to runner_run_path(@runner), notice: 'Run was successfully destroyed. ' }
      format.json { head :no_content }
    end
  end

  private
  def set_run
     @run = Run.find(params[:id])
   end

  def get_runner
    @runner = Runner.find_by_id params[:runner_id]
  end  

  def run_params
    params.require(:run).permit(:runner_id, :date, :training_plan, :progress)
  end
end