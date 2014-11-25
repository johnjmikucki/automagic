require 'rails_helper'

RSpec.describe "donuts/edit", :type => :view do
  before(:each) do
    @donut = assign(:donut, FactoryGirl::create(:donut))
  end

  it "renders the edit donut form" do
    render

    assert_select "form[action=?][method=?]", donut_path(@donut), "post" do
    end
  end
end
