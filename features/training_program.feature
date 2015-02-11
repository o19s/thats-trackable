Feature: Training Program for each Runner
	The application needs to support a individualized running program for each runner.  These programs start out from a template, you are either in Group A, B, or C.  Each group has a specific training details per day over the course of the summer.   Each runner is added to the application and starts out with a training program, but can be customized.   So I may be on a event for Group A, but then a coach can come in and adjust it.

	Scenario: Create Group Training Program 
		Given I am a coach
		When I create a new training program
		Then I can provide a Group Name.

	Scenario: Add Training Event to Group Program
		Given I am a coach
		And I am configuring the training program for Group A
		When I add a new training event
		Then I provide the date of the training event, "June 6th", and the expected distance, "1 mile" and the time at "8 minutes" with some notes "do warmup for 2 minutes, run 5 minutes, and warm down 1 minute"

	Scenario: Add a Runner to the Program
		Given I am a coach
		And I add a new runner to the application
		And I select a Group Training Program Template
		Then the runner has a prefilled set of events.

	Scenario: Customize a Runner's Training Program
		Given I am a coach
		And I have configured a training program for a runner
		When I update a specific days training
		Then the runner sees that specific change.

	Scenario: Athletes may not edit training program 
		Given I am a athlete
		When I open the training program screen
		Then I am blocked from gaining access		

	Scenario: As a ORM, this is how I am thinking
		Given I have a Group A object
		And I have created a TrainingPlan for 6/10/2012 that is 5w, 5r, 5w, 5r, 5w
		And I have created a TrainingPlan for 6/11/2012 that is no training
		And I have created a TrainingPlan for 6/12/2012 that is 5w, 5r, 5w, 5r, 5w
		And I have created a TrainingPlan for 6/13/2012 that is no training
		And I have created a TrainingPlan for 6/14/2012 that is no training
		And I have created a TrainingPlan for 6/12/2012 that is 5w, 8r, 5w, 5r, 5w
		When I add a runner named Eric Pugh to Group A
		Then I can see on his dashboard six TrainingSessions
		And the TrainingSession on 6/10/2012 for 5w, 5r, 5w, 5r, 5w
		And the TrainingSession on 6/11/2012 is of type "unscheduled"
		And the TrainingSession on 6/12/2012 for 5w, 5r, 5w, 5r, 5w
		And the TrainingSession on 6/13/2012 is of type "unscheduled"
		And the TrainingSession on 6/14/2012 is of type "unscheduled"
		And the TrainingSession on 6/15/2012 for 5w, 8r, 5w, 5r, 5w


	Scenario: As a ORM, this is how I am thinking
		Given I have a runner in Group A with a full training plan
		When she updates her TrainingSession on 6/10/2012 with the note that the day was hot, and it took 20 minutes
		Then you can see on the dashboard the day was hot, and the time taken that day was 20 minutes.

	Scenario: As a ORM, this is how I am thinking
		Given I have a runner in Group A with a full training plan
		And she is scheduled to run 40 min ez
		When she gets a cold on 6/12/2012
		Then the TrainingSession on 6/12/2012 is of type "unscheduled"
		And other runners continue to be normally scheduled for 6/12/2012





