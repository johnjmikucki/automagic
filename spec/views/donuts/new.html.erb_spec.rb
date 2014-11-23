require 'rails_helper'

RSpec.describe "donuts/new", :type => :view do
  before(:each) do
    assign(:donut, Donut.new())
  end

  it "renders new donut form" do
    render

    assert_select "form[action=?][method=?]", donuts_path, "post" do
    end
  end
end
