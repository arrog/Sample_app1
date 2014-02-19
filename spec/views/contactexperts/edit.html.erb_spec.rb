require 'spec_helper'

describe "contactexperts/edit" do
  before(:each) do
    @contactexpert = assign(:contactexpert, stub_model(Contactexpert))
  end

  it "renders the edit contactexpert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contactexperts_path(@contactexpert), :method => "post" do
    end
  end
end
