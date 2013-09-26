require 'spec_helper'

describe "assets/index" do
  before(:each) do
    assign(:assets, [
      stub_model(Asset,
        :project => nil,
        :title => "Title",
        :notes => "MyText",
        :visible => false
      ),
      stub_model(Asset,
        :project => nil,
        :title => "Title",
        :notes => "MyText",
        :visible => false
      )
    ])
  end

  it "renders a list of assets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end