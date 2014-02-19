require 'spec_helper'

describe "contactexperts/new" do
  before(:each) do
    assign(:contactexpert, stub_model(Contactexpert).as_new_record)
  end

  it "renders new contactexpert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contactexperts_path, :method => "post" do
    end
  end
end
