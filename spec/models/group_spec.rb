require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @group = Group.new(name: "Ben Franklin Labs")
  end

  subject { @group }

  describe "when name is not present" do 
    before { @group.name = " " }
    it { should_not be_valid }
  end
end

feature 'Groups', js: true do
  scenario 'view' do
    visit '/groups'
    expect(page).to have_content('Group One')
  end
end
