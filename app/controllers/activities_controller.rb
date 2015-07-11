class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = PublicActivity::Activity.all.order('created_at DESC')
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = PublicActivity::Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:key, :parameters, :owner_id)
    end
end
