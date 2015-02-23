class RunnersController < ApplicationController
  before_action :set_runner, only: [:show, :edit, :update, :destroy]

  # GET /runners
  # GET /runners.json
  def index
    @runners = Runner.all
  end

  # GET /runners/1
  # GET /runners/1.json
  def show
  end

  # GET /runners/new
  def new
    @runner = Runner.new
  end

  # GET /runners/1/edit
  def edit
  end

  # POST /runners
  # POST /runners.json
  def create
    @runner = Runner.new(runner_params)

    respond_to do |format|
      if @runner.save
        format.html { redirect_to @runner, notice: 'Runner was successfully created.' }
        format.json { render :show, status: :created, location: @runner }
      else
        format.html { render :new }
        format.json { render json: @runner.errors, status: :unprocessable_entity }
      end
    end
    #Assigning all existing plans to runner as individual training plans
    Grouptrainingplan.all.each do |plan|
      if plan.group_id.to_s == runner_params[:group_id]
        indPlan = Individualtrainingplan.new
        run = Runner.last
        indPlan.runner_id = run.id
        indPlan.date = plan.date
        indPlan.trainingplan = plan.trainingplan
        indPlan.grouptrainingplans_id = plan.id
        indPlan.save
      end
    end
  end

  # PATCH/PUT /runners/1
  # PATCH/PUT /runners/1.json
  def update

    currentRunner = Runner.find(params[:id])
    #Change Individual Training plans if group is updated on runner
    if currentRunner.group_id.to_s != runner_params[:group_id]
      Individualtrainingplan.all.each do |plan|
        if plan.runner_id.to_s == currentRunner.id.to_s
          plan.destroy
        end
      end
      Grouptrainingplan.all.each do |groupPlan|
        if groupPlan.group_id.to_s == runner_params[:group_id]
          indPlan = Individualtrainingplan.new
          indPlan.runner_id = currentRunner.id
          indPlan.date = groupPlan.date
          indPlan.trainingplan = groupPlan.trainingplan
          indPlan.grouptrainingplans_id = groupPlan.id
          indPlan.save
        end
      end
    end

    respond_to do |format|
      if @runner.update(runner_params)
        format.html { redirect_to @runner, notice: 'Runner was successfully updated.' }
        format.json { render :show, status: :ok, location: @runner }
      else
        format.html { render :edit }
        format.json { render json: @runner.errors, status: :unprocessable_entity }
      end
    end


  end

  # DELETE /runners/1
  # DELETE /runners/1.json
  def destroy
    #Delete all individual training plans
    currentRunner = Runner.find(params[:id])
    Individualtrainingplan.all.each do |indPlan|
      if indPlan.runner_id.to_s == currentRunner.id.to_s
        indPlan.destroy
      end
    end

    @runner.destroy
    respond_to do |format|
      format.html { redirect_to runners_url, notice: 'Runner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_runner
      @runner = Runner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def runner_params
      params.require(:runner).permit(:name, :group_id, :role)
    end
end
