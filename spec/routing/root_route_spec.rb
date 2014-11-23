require 'rails_helper'

describe "default route", :type => :routing do
  it 'should route / to the donut index' do
    expect(:get => "/").to route_to(:controller => "donuts", :action => "index")
  end

  # it "should not show the default rails page" do
  #   render
  #   expect(rendered).not_to match /You’re riding Ruby on Rails!/
  # end
end