require 'spec_helper'

describe "Hills pages" do

  subject { page }

  describe "index" do
    before(:all) {30.times { FactoryGirl.create(:hill) } }
    before { visit hills_path }
    after(:all)  { Hill.delete_all }

    it { should have_title('All hills') }
    it { should have_content('All hills') } 

    it "should list each hill" do
        Hill.all do |hill|
          expect(page).to have_selector('td', text: hill.name)
        end
    end

  end

end