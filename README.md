# Phyziq
Final Bitmaker Project. Phyziq is a site which connects users to Personal Trainers in their city and allows them to book Training Sessions with each other.

## View the deployed version `http://phyziq.herokuapp.com`
The key feature behind this Rails App is it's use of Google OAuth and Calendar API.
Users login through their gmail accounts, then Phyziq checks over events on the user's primary Calendar to find available time slots over the next seven days. This information is displayed on a user's Public Profile page.
Based on this, users are able to invite trainers to a training session by clicking on an available time slot (which will appear as links) of a trainer's schedule. Doing so will create an event on both the user's and trainer's calendar, using the trainer's address as the event address.
Event details can also be viewed, and events can be deleted through the Event Details page. Deleting an event removes the data from both Phyziq's database and a user's Google Calendar.

## Other Features
* Materialize front-end framework.
* Dynamic dropdown menu links and user profile pages (based on user settings & sessions).
* Fuzzy Search for trainers by name or address using the search bar.
* Search for trainers by "category" (i.e: Boxing, Crossfit, Cardio).
* Users can change their status as a trainer.
* Trainer users can edit their training categories.
* PostgreSQL database.
