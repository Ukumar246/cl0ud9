# cl0ud9-golf-tournament

Hello team! I'll add more info to this README shortly. We can use this place to add instructions on how to bring the application up once its checked in.


## Downloading Ruby & Rails
On a Mac:

1. Open up the terminal window (Finder -> Terminal)  
2. Install the latest Ruby on your machine  
` brew install ruby `  
3. Install Rails  
`sudo gem install rails`  
4. Restart the terminal window  
5. Try out interactive ruby by executing  
`irb`  

## Setting up the Project

You need to have git installed on your machine, then in the terminal window and in your desired directory:  
`git clone https://github.com/cl0ud9-CSC444/cl0ud9.git`

Once the project is checked out, you need to get the required project dependencies, execute the following inside the project directory:
`bundle install`

## DB setup

Mac comes with PostGres, you just need to create a user with username'postgres' pword 'postgres' to work with the existing database.yml settings and continue from step 2.

How to set up your dev db (windows):

1. Download postgreSQL -> in the installer, leave the port as 5432, make password 'postgres'
2. Download pgAdmin (GUI for postgres)
3. run rake db:create:all in your app folder
4. run rake db:setup (this runs all migrations and seed file for you)
5. Open pgAdmin, expand Servers->PostGreSQL 9.6->Databases and you should see two cloud9 databases, cl0ud9_dev and cl0ud9_test. They will probably have x's over them. Double click and enter the 'postgres' password we configured in step 1. If you run queries on the cl0ud9_dev db (open up query window, and for example 'select * from people') there should be data, as least for people, golf_courses, tournaments, and hosts.

On DB update a rake db:migrate must be run.

## DB seed changes
After making changes to db/seeds.rb, repopulate database to avoid duplicates:
 1. run rake db:schema:load
 2. run rake db:seed

## Starting the application

1. In the directory where the project is cloned:
` rails server `


## Running tests

To run end-to-end Cucumber tests:
` rake cucumber `

To run unit tests:
` rake test `
