require 'spec_helper'

describe "contactexperts/index" do
  before(:each) do
    assign(:contactexperts, [
      stub_model(Contactexpert),
      stub_model(Contactexpert)
    ])
  end

  it "renders a list of contactexperts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
