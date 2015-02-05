Feature: Dashboard view of "today" for each runner
	The key point of the application is to provide a single page view for each runner
	of what they are supposed to be doing.  

	We could surface both that day's run details
	as well as a reminder to fill in previous days if they haven't already done that.
	
	The dashboard needs to be mobile optimized, since many runners will pull it up on their phone.  We should do the "would you like to bookmark this page?" popup for their home screens.   

	My thought is that if your name is "Kate Pugh", then the url is http://thats-trackable.org/kate-pugh/.  A very simple "login" process, and it's okay that others can guess what the URL is.      

	Scenario: Open dashboard 
		Given I am an existing user
		And I am in Group B
		And I am supposed to run 60 minutes today
		When I open the dashboard
		Then I can see that I am in Group B
		And I can see I am supposed to run 60 minutes today

	Scenario: Open dashboard and be reminded of previous run
		Given I am an existing user
		And I am in Group B
		And I am supposed to run 60 minutes yesterday
		When I open the dashboard
		Then I am reminded to update my run information from yesterday


	Scenario: Update dashboard view
		Given I am an existing user
		And I am in Group B
		And I am supposed to run 60 minutes today
		When I update the dashboard with my run details
		Then they are saved		


	Scenario: Open dashboard for unknown user
		Given I am a user who doesn't exist in the application
		When I open the dashboard
		Then I am warned that I wasn't found
		And I am reminded of similar accounts
		And I am offered the option to sign up

