require 'spec_helper'

describe "contactexperts/show" do
  before(:each) do
    @contactexpert = assign(:contactexpert, stub_model(Contactexpert))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
