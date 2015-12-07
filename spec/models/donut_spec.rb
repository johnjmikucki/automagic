require 'rails_helper'

RSpec.describe Donut, :type => :model do
  it "has a valid factory" do
    expect(build(:donut)).to be_valid
  end
  it "is invalid without a name" do
    donut = build(:donut)
    donut.name = nil

    expect(donut).not_to be_valid
  end
  it "is valid without ad copy" do
    expect(build(:donut, ad_copy: nil)).to be_valid
  end
  it "is not released by default" do
    expect(build(:donut).released).to eq(false)
  end

  it "has a unique name" do
    d = create(:donut, name: "aaa")
    d2 = build(:donut, name: "aaa")
    expect { d2.save }.to raise_exception ActiveRecord::RecordNotUnique
  end

  it "has no default values for fat, carb, and protein" do
    d = create(:donut)
    expect(d.fat).to be_nil
    expect(d.carb).to be_nil
    expect(d.protein).to be_nil
  end

  it "can't be released without values for fat, carb, and protein" do
    d = create(:donut)
    d.fat=1
    d.carb=1
    d.protein=nil
    d.released = true
    expect(d.validate).to be_falsey
    d.protein=1
    expect(d.validate).to be_truthy
  end

  it "computes a calorie count with all macros present" do
    d = create(:donut)
    d.fat = 1 # 9 cal
    d.carb = 1 # 4 cal
    d.protein = 1 # 4 cal
    expect(d.calories).to equal(17)
  end

  it "returns nil without all macros present" do
    d = create(:donut)
    d.fat = nil
    d.carb = nil
    d.protein = nil
    expect(d.calories).to be_nil
  end
end
