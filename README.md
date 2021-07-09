# Technical challange
These Robot Framework based automated tests are created to complete a technical challange.

## WARNING: Known Issue!
The test website was absolutely not predictable in the last few days.

I got "[Resource Limit Is Reached](https://peterkulik.github.io/automationpractice/Screenshot%20from%202021-07-09%2016-44-01.png)" messages many times from the server.

Please consider this problem and try to run test cases one by one.

Test failures with message like "... did not appear in 30 seconds" are typically occurred because of this problem, but sometimes it occurres failures with other messages.

Chrome and firefox browser based executions' results are available here:
[chrome results](https://peterkulik.github.io/automationpractice/Results/chrome/report.html)
[firefox results](https://peterkulik.github.io/automationpractice/Results/firefox/report.html)

## Installation steps
- Install python 3.8+ and update pip

- [Install webdrivers: Download and place them into a directory that is in PATH.](https://robotframework.org/SeleniumLibrary/#browser-drivers)

- Clone this repository
```bash
git clone git@github.com:peterkulik/automation_practice.git
```

- Create 

## Test execution 
Use the following tags to run different test scenarios:
- register
- search
- add_products
- delete_products
- purchase_products

For instance to run "Successful registration" test scenario:
```bash
robot -d Results -i register Tests
```

To select a browser driver pass a [supported browser name](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser) to the robot command.
```bash
robot -d Results -v BROWSER:chrome Tests
robot -d Results -v BROWSER:firefox Tests
```
All test cases are tested with chrome and firefox.