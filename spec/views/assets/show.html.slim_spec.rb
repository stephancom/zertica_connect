require 'spec_helper'

describe "assets/show" do
  before(:each) do
    @asset = assign(:asset, stub_model(Asset,
      :project => nil,
      :title => "Title",
      :notes => "MyText",
      :visible => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
