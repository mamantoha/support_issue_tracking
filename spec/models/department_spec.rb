require 'rails_helper'

RSpec.describe Department, type: :model do

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  before(:each) { @department = Department.new(name: "IT") }

  subject { @department }

  it "#name returns a string" do
    expect(@department.name).to match 'IT'
  end

  it "should require a name" do
    FactoryGirl.build(:department, name: "").should_not be_valid
  end

  it "should not require a description" do
    FactoryGirl.build(:department, name: "Name").should be_valid
  end
end
