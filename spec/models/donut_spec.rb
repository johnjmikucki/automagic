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

  it "has no default values for fat, carb, and protein" do
    d = FactoryGirl::create(:donut)
    expect(d.fat).to be_nil
    expect(d.carb).to be_nil
    expect(d.protein).to be_nil
  end

  it "can't be released without values for fat, carb, and protein" do
    d = FactoryGirl::create(:donut)
    d.fat=1
    d.carb=1
    d.protein=nil
    d.released = true
    expect(d.validate).to be_falsey
    d.protein=1
    expect(d.validate).to be_truthy
  end

end
