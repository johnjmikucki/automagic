require 'rails_helper'

RSpec.describe "donuts/index", :type => :view do
  before(:each) do
    assign(:donuts, [
      Donut.create!(),
      Donut.create!()
    ])
  end

  it "renders a list of donuts" do
    render
  end
end
