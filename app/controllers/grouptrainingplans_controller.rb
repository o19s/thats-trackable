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
  end

  def destroy
    @grouptrainingplan.destroy
    respond_to do |format|
      format.html { redirect_to grouptrainingplans_url, notic: 'Group Training Plan was successfully deleted. '}
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