require 'spec_helper'

describe Performance do
  let(:user) { FactoryGirl.create(:user) }
  let(:debate) { FactoryGirl.create(:debate) }
  let(:performance) { user.performances.build(debate_id: debate.id) }
  
  subject { performance }
  
  it { should respond_to(:position) }
  it { should respond_to(:rating) }
  it { should respond_to(:user_id) }
  it { should respond_to(:debate_id) }
  its(:user) { should == user }
  its(:debate) { should == debate }
  
  it { should be_valid }
  
 
  describe "when user id is not present" do
    before { performance.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when debate id is not present" do
    before { performance.debate_id = nil }
    it { should_not be_valid }
  end 
   
end
