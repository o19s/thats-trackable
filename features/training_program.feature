Feature: Training Program for each Runner
	The application needs to support a individualized running program for each runner.  These programs start out from a template, you are either in Group A, B, or C.  Each group has a specific training details per day over the course of the summer.   Each runner is added to the application and starts out with a training program, but can be customized.   So I may be on a event for Group A, but then a coach can come in and adjust it.

	Scenario: Create Group Training Program 
		Given I am a coach
		When I create a new training program
		Then I can provide a Group Name.

	Scenario: Add Training Event to Group Program
		Given I am a coach
		And I am adding events to Group A
		When I add a new training event
		Then I provide a date and a distance and a time.

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

