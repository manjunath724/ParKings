# ParKings

A Parking lot system to allot slots in the floor of a building for the user cars as a service to the request - either manually or automatic(Let the system decide upon the suitable slot from the available free slots).

## Problem Statement
Build a Parking lot system to automate the manual process. Users should be able to perform following operations/tasks:
- Car owners enroll themselves to the Application
- Enter their car(s) details
- Request for Parking slot
- Release the Slot at later point
<hr>

- Admin should be able to add the available Parking space information like Building, Floors and Slots
- Manually/Automatically allot the Slot from available list of free slots
- Discharge the Slot to make it available for next User
<hr>

- Program must capture the Entry Time, Exit Time, Total Duration and Total Amount - calculated based on the price associated with the Slot.
- Status of the request and action items has to change accordingly at every step.

## Implementation Details
- Admin Account creation has been restricted to take place through `db seed`/`rails console`/etc.
- Admin can `Create`/`Update`/`View`/`Remove` Building/Floor/Slot & Price information.
  - Deletion of a Building has been removed to retain the information.
  - One can remove floors and slots through nested forms.
- Users can `sign_up` and `log_in` to the application.
- Users can `Create`/`Update`/`View` their Cars.
  - Deletion has been removed to retain the information.
- Users can `request` for Parking Slot allotment.
  - User cannot submit duplicate requests for the same car.
  - User can simply choose to `Cancel` the request before Slot allotment.
  - Next request for the given car can be raised only after cancellation or completion of the previous request.
- Admin can either Allot the Available slot or choose to Automate, wherein the System picks up a Slot from available list and allots.
- User can raise a `Release` flag to indicate the discharge.
- Admin confirms the `Discharge` by collecting the Applicable fee.

## Technical Details
- Using 
```ruby
  ruby `2.3.1`
  gem 'rails', '~> 5.2.1'
  gem 'mongoid', '~> 7.0.1'
  gem 'devise'
  gem 'cancancan'
  gem 'nested_form'
  gem 'jquery-rails'
  gem 'bootstrap_form'
  gem 'bootstrap-sass', '~> 3.3.7'
```
- Using Bootstrap `tables`, `buttons` and `bootstrap_form_for`
- Using `navbar-inverse` class for header and footer bar
- Using `alert-success` and `alert-danger` classes for notification bar
- UI Normalization is being followed with respect to tables, buttons and other elements
- User `role` check and Request `status` checks are performed through `meta-programming`
- A frozen hash of status is being used and scopes are created dynamically
- Two level nested forms have been implemented for Builing -> Floors -> Slots
- Required set of validations have been added in place.
- CSS has been written for table responsiveness, a fixed footer with background and text decorations, etc.

## Steps to setup and run the project on Ubuntu
- Clone the repository using [`git clone`](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository) command.
- CD into the repository and run `bundle install` and `rake db:create db:seed`.
  - Follow the on screen instructions to create an Admin account.
- Start `rails server`.
- visit `localhost:3000` in your browser.
- `devise` authenticator will prompt you to sign_in / sign_up.
  - Sign up with your email id and sign in as an user to the ParKings application.
  - Please note, mailers haven't been setup. Ergo, you wouldn't receive any emails.
  
  ### Admin login
  - Upon successful login, you will be redirected to the Home page which lists the incoming requests.
    - You can allot the slot manually or use the automate button for the system to allot a random slot.
    - You can discharge the Slot upon Release request made by the User.
  - You can navigate to `Buildings` using the link on header navbar. To perform below operations:
    - To **Add** a Building with floor and slots information
      - Set price per slot
    - To **Edit** a Building/floor/slot information
    - To **Remove** a Building and all related requests
  - A link to **sign_out** is placed at the top-right corner.
  
  ### User login
  - Upon successful login, you will be redirected to the Home page which lists the slot requests you have made.
    - You can cancel the request for which the Slot is not alloted yet.
    - You can request for Slot Release.
    - You can View the details of all requests with total payable amount w.r.t entry and exit time duration.
  - You can navigate to `My Cars` using the link on header navbar. To perform below operations:
    - To **Add** a Car information
      - Registration number, model and color
    - To **Edit** a Car information
    - To **Request** for a Parking Slot
  - A link to **sign_out** is placed at the top-right corner.

## Future Enhancements
- Ability for a `SuperAdmin` to create other Admin/Operation team accounts.
- Verification of registered User accounts.
- Soft delete option to remove the `Car`/`Building`/`Floor`/`Slot` entry.
- Automation of "Slot allotment or release" for the User cars upon request.
- Setting price according to the requirement - At Floor level/Building level/etc.
- Automatic Slot allotment strategy can be changed
  - Based on priority set to Building/Floor/Slot
  - Based on Brand/Class that the car falls under
  - Based on special instructions that the user has provided, etc.
