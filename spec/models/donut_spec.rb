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
    expect { d2.save }.to raise_exception
  end
end
