require 'rails_helper'

RSpec.describe "donuts/index", :type => :view do
  before(:each) do
    assign(:donuts, [
                      FactoryGirl::create(:donut),
                      FactoryGirl::create(:donut)
                  ]
    )
  end

  it "renders a list of donuts" do
    render
  end
end
