require 'spec_helper'

describe Debate do

 let(:debate) { FactoryGirl.create(:debate) }

  subject { debate }

  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:type_of_debate) }
  it { should respond_to(:performances) }
  it { should respond_to(:users) }
  it { should respond_to(:participate!) }

  it { should be_valid }

  before do
    debate.save
  end
  
  describe "with blank content" do
    before { debate.content = " " }
    it { should_not be_valid }
  end


  describe "with blank title" do
     before { debate.title = " " }
     it { should_not be_valid }
  end
   
  #A amerliorer, pour piocher dans la liste des débats 
  describe "with blank type of debate" do
     before { debate.type_of_debate = " " }
     it { should_not be_valid }
  end 
   
   
end
