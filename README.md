# ELMO
ELMO is a mobile data collection and analysis web application. Originally designed for the [Carter Center](http://www.cartercenter.org) for election observation missions, ELMO can be used in many different contexts for data collection missions.

Consider ELMO if you need:

- Highly customizable and standardized forms
- User and mission management
- Sophisticated, real time reporting

To learn more about the history and goals of the project, [visit the ELMO project site](http://elmo-site.sassafrastech.com)
You can also learn more about The Carter Center's Election Standards [here](http://cartercenter.org)

## How Do I Install ELMO ?

In the future, we hope to offer managed instances of ELMO. In the meantime, you can follow these instructions to install your own instance of ELMO.

### Package Managers

Note to install the following software we recommend the following package managers:

- Mac OS X: MacPorts or Homebrew
- Linux/Ubuntu: dpkg or bundled package manager
- Windows: Npackd

### Required Software

1. **Ruby 1.9.3+**

2. **Memcached**
	- A good resource on how to install on a Mac is [here](http://www.jroller.com/JamesGoodwill/entry/installing_and_configuring_memcached)
	- Ensure memcached is running.

3. **MySQL 5.0+**
	- Create an empty database and accompanying user for use by the app (E.g. development database *elmo_d* with username *elmo*)

4. **Retrieve project files using Git**
	
  ```
  git clone https://github.com/thecartercenter/elmo.git
  ```

### Configure
1. **Bundle, configure, and migrate**
	- Install the required gems by running *bundle install* in the project directory
	- Copy config/database.yml.example to config/database.yml and edit database.yml to point to your database.
	- Copy config/initializers/local_config.rb.example to config/initializers/local_config.rb and adjust any settings.
	- Run database migrations: *rake db:migrate*
	- Create an admin account: *rake db:create_admin*
	- Start the server using: *rails s*

5. **Login**
	- Navigate to http://localhost:3000 or specified port
	- Login using *admin/testtest* (make sure to change the password)
	- Create a new Mission and get started making forms!



## How Do I Contribute to ELMO?
ELMO is **100% open-source**. We would like you to be part of the ELMO community! We accept and encourage contributions from the public.

### Reporting Bugs

### Requesting New Features

### Contributing
1. **Clone the Repo**

  ```
	git clone https://github.com/thecartercenter/elmo.git
  ```

2. **Create a New Branch**
  
  ```
	cd elmo
	git checkout -b new_elmo_branch
  ```

3. **Code**
	* Adhere to common conventions in the existing code
	* Include tests and make sure they pass

4. **Commit**
	- If you have several commits, please make sure that they are **squashed** into one commit.

  ```
  git remote add upstream https://github.com/thecartercenter/elmo.git
  git fetch upstream
  git checkout new_elmo_branch
  git rebase upstream/master
  git rebase -i
  < Choose 'squash' for all of your commits except the first one. >
  < Edit the commit message to make sense and describe all your changes. >
  git push origin new_elmo_branch -f
  ```

  Now you can commit:

  ```
  git commit -a
  ```

  **NEVER leave the commit message blank!** Provide a detailed, clear, and complete description of your commit!

5. **Update Your Branch**

  ```
  git checkout master
  git pull --rebase
  ```

6. **Fork**

  ```
  git remote add mine git@github.com:<username>/elmo.git
  ```

7. **Push to Your Remote**

  ```
  git push mine new_elmo_branch
  ```

8. **Issue a Pull Request**
  - Navigate to the ELMO repo you pushed to (e.g. https://github.com/username/elmo)
  - Click "Pull Request"
  - Write your branch name in the field (filled with "master" by default)
  - Click "Update Commit Range"
  - Verify the changes are included in the "Commits" tab
  - Verify that the "Files Changed" include all your changes
  - Enter details about your contribution with a meaningful title.
  - Click "Send pull request"

9. **Feedback**

  The ELMO team may request changes to your code. Learning and communication is part of the open source process!










