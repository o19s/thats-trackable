require 'test_helper'

class RunnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @runner = runners(:one)
    @planned_run = planned_runs(:one)
    @group = groups(:one)
  end

  test "should create runner" do
    runner = Runner.new
    assert_not runner.save #fail if runner cannot be created
  end

  test "should_have_planned_runs" do
    #create runner
    new_runner = Runner.create(id: @runner.id, name: @runner.name, group_id: @runner.group_id, role: @runner.role, email: @runner.email, password_digest: @runner.password_digest )
    assert_not new_runner.save

    # Making sure runner has runs
    for i in new_runner.runs
      count += 1
    end

    assert (count = 0)

  end

end
