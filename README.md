#

# Projects App

## About

- Project conversation history. A user should be able to:

  - leave a comment
  - change the status of the project
  - The project conversation history should list comments and changes in status.

## Getting Started

- This project requires Ruby 3.2.1 and Rails 7.0.4.3

- Installation
  - clone the repo
  - `$ cd ~/path/to/ProjejctsApp`
  - `$ bundle`
  - Run `$ bin/rails db:setup`
  - Visit `http://localhost:3000/` in your browser

## Running tests

- Seed the test database `$ bin/rails db:setup RAILS_ENV=test`
- Run `$ bundle exec rspec`

## Known weaknesses

- I would have preferred to use UUIDs for the database but sqlLite does not support them. Given the time and the task requirements, I have opted to go with IDs as integers.

- The project is assuming there is only one user in the application, which is the first user in the database. In real life, the user should be fetched from the params provided by the front end.

- CommentCreateService class has no unit tests. It is being tested via the request tests which is not ideal but enough in my opinion for the task and the time given. In a real life scenario it should include unit tests.

- Given the time restrictions for the task, there is no user authentication/authorization implemented

#

# Questions for the team

- Q: Can an user comment in more than one project?
- A: An user can comment in many projects.

- Q: Does the order of the comments shown matter? Should we show the latest comment at the top of the list
- A: Yes, comments and projects should be listed by the most recent at the top of the list.

- Q: Does an user have to be assigned to a project before they can comment?
- A: Yes, an user can only comment in projects they belong to.

- Q: Can any user change the status of the project, or do they need specific authorization?
- A: All users can change the status of the project.

- Q: What status can a project have? Do they need to be in a specific order?
- A: Projects can change status without constraints, but they always have to have a status.

- Q: Is there a default status for a project?
- A: A project status defaults to "To Do", other status are: 'Pending', 'In Progress', 'Blocked'

- Q: What are the attributes a project should have?
- A: Tittle, optional description, status.

- Q: Do we expect to have many comments per project and many projects?
- A: We can assume in the long term a project will have lots of comments and we will have many projects stored.
