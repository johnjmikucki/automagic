

# Installing Docker

sudo yum install 'docker' # or 'docker-io' depending on your host OS/version

* Note: If you need to run a private repo, you'll probably want one of these images to prettify the UI:

If you don't already have a docker hub, get one:
docker pull docker-hub
> NAME                                    DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
> atcol/docker-registry-ui                A web UI for easy private/local Docker Reg...   21                   [OK]
> konradkleine/docker-registry-frontend   a pure web-based solution for browsing and...   4                    [OK]
> tomaskral/docker-registry-web                                                           0                    [OK]
> cloudaku/docker-registry-web                                                            0                    [OK]
> geodan/registry-ui                      Docker Registry Web Interface                   0                    [OK]

Note: Docker deliberately prevents you from changing the 'root'/default hub/index for things like Centos.  They want it
to point to them ostensibly for consistency (laudable) and probably market share  (quel surprise).
Easiest way to work around this is probably to just spoof the DNS entry for docker.io to your in-house docker hub.


# Jenkins

If you don't already have a Jenkins container, "sudo docker pull jenkins"
(this will take a fair bit of bandwidth)

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

> describe "default route", :type => :routing do
>   it 'should route / to the donut index' do
>     expect(:get => "/").to route_to(:controller => "donuts", :action => "index")
>   end
>
>   # it "should not show the default rails page" do
>   #   render
>   #   expect(rendered).not_to match /You’re riding Ruby on Rails!/
>   # end
> end

Running 'rake spec' shows you your new tests fail! and so now we can add the code that should allow them to pass:

(in config/routes.rb)

>   # You can have the root of your site routed with "root"
>   root 'donuts#index'

You'll see a bunch of messages about "Pending:" attributes.  These are our "TODO"s-- places where rspec-rails has
added boilerplate tests but needs our semantic understanding of our model to seal the deal.  Let's go ahead now and give
our DonutController some 'known-good' sample data so we can run those tests.  (Note that we can't give examples of
invalid data yet -- without constraints or validations, no data is invalid!)

So, in spec/controllers/donuts_controller_spec.rb

>  # This should return the minimal set of attributes required to create a valid
>   # Donut. As you add validations to Donut, be sure to
>   # adjust the attributes here as well.
>   let(:valid_attributes) {
>     #skip("Add a hash of attributes valid for your model")
>     {
>         name: "plain",
>         released:true,
>         ad_copy: "The classic.  Put it in your coffee."
>     }
>   }

