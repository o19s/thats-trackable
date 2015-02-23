class IndividualtrainingplansController < ApplicationController
  before_action :set_individualtrainingplan, only: [:show, :edit, :update, :destroy]

  def index
    @individualtrainingplan = Individualtrainingplan.all
  end

  def show
  end

  def new
    @individualtrainingplan = Individualtrainingplan.new
  end

  def edit
  end

  def create
    @individualtrainingplan = Individualtrainingplan.new(@individualtrainingplan_params)

    respond_to do |format|
      if @individualtrainingplan.save
        format.html {redirect_to @individualtrainingplan, notice: 'Individual Training Plan was successfully created.' }
        format.json {render :show, status: :created, locations: @individualtrainingplan }
      else
        format.html { render :edit }
        format.json { render json: @individualtrainingplan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @individualtrainingplan.destroy
    respond_to do |format|
      format.html { redirect_to individualtrainingplans_url, notice: 'Individual Training Plan was successfully destroyed. ' }
      format.json { head :no_content }
    end
  end

  private
  def set_individualtrainingplan
    @individualtrainingplan = Individualtrainingplan.find(params[:id])
  end

  def individualtrainingplan_params
    params.require(:individualtrainingplan).permit(:runner_id, :date, :trainingplan, :progress)
  end
end