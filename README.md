# Marvelous - Marvel Comics Browser


## Get up and running

To install and run you'll need to have:

* ruby 2.3
* bundler
* native build tools (on my case - ubuntu - `sudo apt install build-essentials`)
* native sqlite3 dev libs (`sudo apt install sqlite3-dev`)

Next you'll need the usual bootstrap commands:

* `bundle install`
* create a `.env` file with your Marvel API keys (I've included mine but on a normal project I wouldn't)
* `bin/rake db:create && bin/rake db:migrate`

This ought to be enough to get you going...


## Running tests

To run tests just `bin/rspec spec` on the project root.

**NOTE:** for some very very odd reason, I get a false negative in one test on cold runs (might be something weird with spring, idk)


## Architecture and Design

I've detoured a bit from normal Rails Architecture into something resembling (from a far) the Hexagonal Arch.
I've attached a small schematic @ docs/diagram.jpg

Rails sits on the outer part of the app - as an adapted that could be exchanged by some other one - while the core tries its best to be rails-free (except for a small part that wouldn't be all that hard to extract but it would be overkill in this situation).

**Controllers** communicate with **Commands** that in turn ask for data to **Repositories**.
The **Commands** expose a set of callbacks that the **Controllers** can latch onto.

**Repositories** communicate with the outside world (aka Marvel API) and translate the responses into meaningful objects to the system.

All over the core, classes implement a form of Dependency Injection to allow for easy testing and for the code to be more meaningful.


## A note on some missing tests

There should be a couple of tests to cover the favorite toggle thingy, but setting up Cucumber just for something like that would by far outweigh the benefit, so I left it for last, but now time as ran out, so I guess I'll leave it uncovered.. sorry!


