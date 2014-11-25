
# Do You Want To Build A Web App?

I'm going to use ruby/rails for this since it has really nice 'Just give me a REST API already' commands.  You can do
it in Java or Perl or Python or Haskell or whatever makes you happy.  Your build commands on the Jenkins server will
be a bit different from mine.

First, create a git repo- mine's called automagic.  Use the "give me a README.md so I can check it out now" button.

Then, clone your new repo via e.g.

    git clone git@github.com:johnjmikucki/automagic.git


# Install RVM, if needed (via rvm.io)

# Build That App

We're going to write ourselves a trivial little webapp.  Basically it will be a web-enabled scientific calculator.

## We'll generate ourselves a skeleton rails app in that folder.

    rails new automagic

<wait for it>

and then browse to localhost on 3000 to verify it's actually working.

Huzzah!  Time to commit and push.

    git commit -m "roughed in webapp skeleton"
    git push

There's probably a nice way to write automated tests for "does the damned thing start" but I'll figure that out later.

## Time to write some code!

OK, time to make the donuts.  Since our app is designed around resources and RESTful APIs, we'll start by modeling and exposing
a Donut API.  Rails makes it cheap to rough in a new resource, so we'll do that first:

    rails g scaffold donut name:string:uniq ad_copy:text released:boolean
    rake db:migrate
(Rails generates the database schema changes for us.  This command applies the changes to the current (dev) db.)

and finally

    rails server
(which fires up a lightweight (single-threaded, not-production-ready) web server to host your app)
you can view it at: http://127.0.0.1:3000

Now we have something we can show a user and argue about.  Everything so far has been canned so I haven't been too
fussed about testing - but now that I'm going to start breaking^Wfixing things, I do.  I'm going to show you rspec,
since that's perhaps the premier and preeminent Ruby testing framework - and its domain-specific language is readable
even if you don't speak Ruby.

So let's get the rails rspec helper gem (https://github.com/rspec/rspec-rails) set up and then generate the default
tests:

    rails generate rspec:scaffold donut

Have a look through the files it generates.

## First blood: Landing page

When you visited 127.0.0.1:3000, you got the standard Rails "Welcome!" landing page.  Which is fine for us but not
much for users.  Since this is an app about donuts, let's take users right to the Donut Index (/donuts).

Since this is Test Driven Development, we're going to write a test to validate the system does what we want.  Then,
we're going to run it - it should fail.  Then, we'll write the code that fixes the failure.  Then we'll run the test
again.  And once it passes, we're free to refactor our code to clean up any technical debt / make any optimizations.

Note: If you were trying to write a test that passes first  (e.g. test that GET "/" takes you to that welcome page)
I'll save you some time: it seems to be a dressed-up version of an  internal rails error page.

#### Step 1: Write the test

By convention, tests (called 'specs' in Ruby-speak) for routes live in the spec/routes folder.  So I've created
route_route_spec.rb and put these tests in it:

    describe "default route", :type => :routing do
      it 'should route / to the donut index' do
        expect(:get => "/").to route_to(:controller => "donuts", :action => "index")
      end

      # it "should not show the default rails page" do
      #   render
      #   expect(rendered).not_to match /You’re riding Ruby on Rails!/
      # end
    end

Run
    rake spec

and watch your new tests fail! Now we can add the code that should allow them to pass:

(in config/routes.rb)

>   # You can have the root of your site routed with "root"
>   root 'donuts#index'

You'll see a bunch of messages about "Pending:" attributes.  These are our "TODO"s-- places where rspec-rails has
added boilerplate tests but needs our semantic understanding of our model to seal the deal.  Let's go ahead now and give
our DonutController some 'known-good' sample data so we can run those tests.

So, in spec/controllers/donuts_controller_spec.rb

    # This should return the minimal set of attributes required to create a valid
    # Donut. As you add validations to Donut, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      #skip("Add a hash of attributes valid for your model")
      {
          name: "plain",
          released:true,
          ad_copy: "The classic.  Put it in your coffee."
      }
    }


 ## A Donut with No Name

Note that we can't give examples of invalid data yet -- without constraints or validations, no data is invalid!  That's
the sort of bug that will bite us during a demo, so let's fix that first.  No ad copy is no problem, but a donut needs
at least a name and whether or not it's publicly-available.  We decide that names should be mandatory and unique, and
that the 'released' boolean should be mandatory and default to false.  (Secrecy is everything in the cutthroat donut
business.)

Test-driven development follows a pattern: "Red-Green-Refactor".  First, we write specs for the behavior we want.  These
specs (usually) fail, leaving us in the state of "red" - things are broken.  Then we write code until all our specs pass
again, leaving us "Green".  At this point, we can pay down any technical debt - refactor any code that needs it - and
do so with brutal efficiency and great confidence that we haven't broken something else we cared about - because all our
specs pass green.

Note that it's a good idea to write specs for features even when we don't think any part of them are implemented.  This
is because it:

* helps us explore desired behavior before we start implementation,
* can save us time if by good luck something already behaves the way we want.
* helps us be confident that if a later change breaks something we thought was done, we detect it quickly while the
breaking changes are fresh in our minds.


So let's go write some specs.

### Step 1: The Code you wish you had



First, I'm going to generate a template for the Donut model we have (you may already have one):

    rails generate rspec:model Donut

...which gets you this:

    require 'rails_helper'

    RSpec.describe Donut, :type => :model do
      pending "add some examples to (or delete) #{__FILE__}"
    end

We then stub out some specs for the Donut Model:

    RSpec.describe Donut, :type => :model do
      it "has a valid factory"
      it "is invalid without a name"
      it "is valid without ad copy"
      it "is not released by default"
      it "is not valid if another donut has the same name"
    end

and then running our test suite with 'rake' reminds us the specs need to be implemented:

     Donut is invalid without a name
        # Not yet implemented
        # ./spec/models/donut_spec.rb:4
      Donut is valid without ad copy
        # Not yet implemented
        # ./spec/models/donut_spec.rb:5
      Donut is not released by default
        # Not yet implemented
        # ./spec/models/donut_spec.rb:6
      Donut is not valid if another donut has the same name
        # Not yet implemented
        # ./spec/models/donut_spec.rb:7


To do that, we're going to leverage FactoryGirl, a ruby gem which replace fixtures (hardcoded test values) with values
from a factory; and Faker, which provides randomized values for common fields.  Adding these to our Gemfile lets us
dummy up an implausible donut name and some Lorem Ipsum text to fill the ad copy.  Which frankly would be cheaper and
more interesting than actual ad copy.

    FactoryGirl.define do
      factory :donut do |f|
        f.name {Faker::Commerce.product_name}
        f.ad_copy { Faker::Lorem.paragraph(3) }
      end
    end


and now we'll start fleshing out our donut specs:

    require 'rails_helper'

    RSpec.describe Donut, :type => :model do
      it "has a valid factory" do
        expect(FactoryGirl::create(:donut)).to be_valid
      end
      it "is invalid without a name" do
        expect(FactoryGirl::build(:donut, {name: nil})).not_to be_valid
      end
      it "is valid without ad copy" do
        expect(FactoryGirl::create(:donut, {ad_copy: nil})).to be_valid
      end
      it "is not released by default" do
        expect(FactoryGirl::build(:donut).released).to eq(false)
      end

      it "has a unique name" do
        d =FactoryGirl::create(:donut, name: "aaa")
        d2 =FactoryGirl::build(:donut, name: "aaa")
        expect {d2.save}.to raise_exception
      end
    end



at which point we see:

    expected #<Donut id: 1, name: nil, ad_copy: "Maxime sequi impedit quaerat. Et tempore neque rep...", released: true, created_at: "2014-11-24 22:16:41", updated_at: "2014-11-24 22:16:41"> not to be valid
    ./spec/models/donut_spec.rb:10:in `block (2 levels) in <top (required)>'

    expected: falsey value
         got: true
    ./spec/models/donut_spec.rb:16:in `block (2 levels) in <top (required)>'


which tells us that our spec is now running and failing.  Now let's make it pass by constraining the model so names are
required. Fortunately that's a common thing and Rails has a shortcut for it.  In our model, we add:

    :validates_presence_of :name

and retest.

 ## Now implement that code

We'll add a DB migration to default donuts' released status to 'false':

    class DonutDefaultUnreleased < ActiveRecord::Migration
      def change
        change_column_default :donuts, :released, false
      end
    end

And with those tests passing, we'll check in our code.


 ## Nutritional Value

 Our customer has gotten themselves on a diet kick and - however improbably - wants to track nutritional information
 for the donuts they sell.  Improbable as it is that donuts are considered health food, they'd like to see donuts'
 macronutrients (fat, carbs, protein) content captured and made available.  Let's add those features now.





 Before we get further into the test and development cycle, let's get the test and build process automated. We'll be
 using Jenkins and Docker to automate our (trivial) build, test, and deployment-packaging process.

# Installing Docker

 sudo yum install 'docker' # or 'docker-io' depending on your host OS/version

 * Note: If you need to run a private repo, you'll probably want one of these images to prettify the UI:

 If you don't already have a docker hub, get one:

    docker pull docker-hub
    NAME                                    DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
    atcol/docker-registry-ui                A web UI for easy private/local Docker Reg...   21                   [OK]

 Note: Docker deliberately prevents you from changing the 'root'/default hub/index for things like Centos.  They want it
 to point to them ostensibly for consistency (laudable) and probably market share  (quel surprise).
 Easiest way to work around this is probably to just spoof the DNS entry for docker.io to your in-house docker hub.


# Deployment provisioning

OK, now we've got an application and we want to package it up into a Docker container where it can run.

Let's build ourselves a container to host our application.  We're going to do it all one one docker container for now.

    # docker image for running CC test suite

    FROM ubuntu

    RUN apt-get -y install wget
    RUN apt-get -y install git

    # install Ruby 2.1.5
    RUN apt-get -y install build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev
    RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    ENV PATH /.rbenv/bin:/.rbenv/shims:$PATH
    RUN echo PATH=$PATH
    RUN rbenv init -
    RUN rbenv install 1.9.3-p484 && rbenv global 1.9.3-p484

    # never install a ruby gem docs
    RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

    # Install bundler and the "bundle" shim
    RUN gem install bundler && rbenv rehash

    # Checkout the cloud_controller_ng code
    RUN git clone -b master git://github.com/cloudfoundry/cloud_controller_ng.git /cloud_controller_ng

    # mysql gem requires these
    RUN apt-get -y install libmysqld-dev libmysqlclient-dev mysql-client
    # pg gem requires this
    RUN apt-get -y install libpq-dev
    # sqlite gem requires this
    RUN apt-get -y install libsqlite3-dev

    # Optimization: Pre-run bundle install.
    # It may be that some gems are installed that never get cleaned up,
    # but this will make the subsequent CMD runs faster
    RUN cd /cloud_controller_ng && bundle install

    # Command to run at "docker run ..."
    CMD if [ -z $BRANCH ]; then BRANCH=master; fi; \
        cd /cloud_controller_ng \
        && git checkout $BRANCH \
        && git pull \
        && git submodule init && git submodule update \
        && bundle install \
        && bundle exec rspec spec


# Jenkins

 If you don't already have a Jenkins build server, grab a container for one:

    docker pull jenkins:latest
    docker pull maestrodev/build-agent:latest

 (the 'latest' is important on some repos- otherwise you get all the versions in history)

 Fire it up:

    sudo docker run -p 8080:8080 jenkins

 If you're running this on a dedicated host, you won't need the '-p' option, which does basically port-address
 translation (exposing port 8080 from the docker container on the host post 8081).  Browse over there and check it out.


## Configure Your Jenkins Build

Now we need to set up an automated build for our