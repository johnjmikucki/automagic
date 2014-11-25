require 'rails_helper'

RSpec.describe "donuts/show", :type => :view do
  before(:each) do
    @donut = assign(:donut, FactoryGirl::create(:donut))
  end

  it "renders attributes in <p>" do
    render
  end
end
