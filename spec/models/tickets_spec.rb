require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:department) { FactoryGirl.create :department, name: 'Test name' }

  context 'validations' do
    it { should validate_presence_of(:name) }
  end


  before(:each) { @ticket = Ticket.new(name: "Name", email: 'test@example.com', subject: 'Subject', body: 'Body', department_id: department.id) }

  subject { @ticket }

  it "#name returns a string" do
    expect(@ticket.name).to match 'Name'
  end

  it "should require a name" do
    FactoryGirl.build(:department, name: "").should_not be_valid
  end

  it "should not require a description" do
    FactoryGirl.build(:department, name: "Name").should be_valid
  end

  describe 'display_id' do
    let(:ticket) { Ticket.create!(name: "Name1", email: 'test1@example.com', subject: 'Subject1', body: 'Body1', department_id: department.id) }

    it 'should have a display_id on create' do
      ticket.display_id.should_not be_nil
    end

    it 'should have an unique display_id' do
      ticket2 = Ticket.create!(name: 'Name 2', email: 'test2@example.com', subject: 'Subject2', body: 'Body2', department_id: department.id)
      ticket2.display_id.should_not == ticket.display_id
      ticket2.display_id.should_not be_nil
    end

    it 'should raise an exception after 5 attempts to generate an unique display_id if the same display_id is present' do
      Ticket.should_receive(:generate_display_id).at_least(5).times.and_return("ABC-4F-ABC-8D-ABC")

      expect {
        ticket2 = Ticket.create!(name: 'Name 2', email: 'test2@example.com', subject: 'Subject2', body: 'Body2', department_id: department.id)
        ticket2.display_id.should_not == ticket.display_id
      }.to raise_exception(ActiveRecord::RecordNotUnique)
    end

  end
end
