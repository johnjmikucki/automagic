require 'rails_helper'

RSpec.describe "donuts/show", :type => :view do
  before(:each) do
    @donut = assign(:donut, Donut.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
