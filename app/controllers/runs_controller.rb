class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :destroy]
  before_action :get_runner


  def index
    if @runner
      @runs = @runner.runs.sorted #order('date DESC')
    else
      @runs = Run.all.order('date DESC')
    end
    #@run = @runs.first

  end

  def show
    if @runner
      @runs = @runner.runs.order('date DESC')
    else
      @runs = Run.all.order('date DESC')
    end
    commontator_thread_show(@run) # have the comment thread be open in the page.
    render :index
  end



  def new
    @run = Run.new
  end

  def edit
    @original_planned_run = PlannedRun.find_by_id(@run.planned_run_id)
  end

  def update

    today_view_update = (params[:commit] == 'Track It!')

    with_tracking do

      @run = create_run_from_params

    end

    # Check if Run is customized
    #original_run = PlannedRun.find_by_id(@run.planned_run_id)
    #if (original_run)
  #    if original_run.training_plan != @run.training_plan
  #      @run.customize_flag = true
  #      @run.save
  #    else
  #      @run.customize_flag = false
  #      @run.save
  #    end
  #  else
  #    @run.customize_flag = true
  #    @run.save
  #  end

  puts "successful_update is #{@successful_update}"

    respond_to do |format|
      if @successful_update
        #ADD TO FORM AND PASS IN PARAMS
        #updated_run = Run.find_by_id(@successful_update)
        #updated_run.customize_flag = 1
        #updated_run.save
        redirect_path = (today_view_update == true) ? today_path : runner_run_path(@runner, @run)
        format.html { redirect_to redirect_path, notice: "Run for #{@run.date.strftime("%m/%d/%Y")} was successfully updated."}
        format.json { render :show, status: :ok, location: @run }
      else
        require 'pp'
        pp @run.errors
        render_path = (today_view_update == true) ? today_path : 'runs/edit'
        puts "Render path is #{render_path}"
        format.html { render render_path }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    with_tracking do
      @run = create_run_from_params
    end

    respond_to do |format|
      if @run.save
        format.html {redirect_to runner_run_path(@runner, @run), notice: "Run for #{@run.date.strftime("%m/%d/%Y")} was successfully tracked." }
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
      format.html { redirect_to runner_runs_path(@runner), notice: 'Run was successfully destroyed. ' }
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
    params.require(:run).permit(
      :runner_id, :date, :training_plan, :progress, :customize_flag,
      :duration, :pace, :mileage
    )
  end

  def with_tracking
    Run.public_activity_on
    yield if block_given?
    Run.public_activity_off
  end

  def create_run_from_params()
    if run_params['date']
      date_string = run_params['date']
      date = DateTime.strptime(date_string, '%m/%d/%Y')
      params[:run][:date] = date


      puts "params[:run][:date]: #{params[:run][:date].to_date}"
      @run = Run.find_or_create_by date: params[:run][:date].to_date, runner: current_runner
    elsif run_params['date(1i)']
      date_string = "#{run_params['date(2i)']}/#{run_params['date(3i)']}/#{run_params['date(1i)']}"
      puts "date_string: #{date_string}"
      date = DateTime.strptime(date_string, '%m/%d/%Y')
      params[:run][:date] = date


      puts "params[:run][:date]: #{params[:run][:date].to_date}"
      @run = Run.find_or_create_by date: params[:run][:date].to_date, runner: current_runner
    else
      @run = Run.find(params[:id])
    end
    #@run.runner = @runner
    @successful_update = @run.update(run_params)
    @run
  end
end
