require 'spec_helper'

describe "assets/edit" do
  before(:each) do
    @asset = assign(:asset, stub_model(Asset,
      :project => nil,
      :title => "MyString",
      :notes => "MyText",
      :visible => false
    ))
  end

  it "renders the edit asset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asset_path(@asset), "post" do
      assert_select "input#asset_project[name=?]", "asset[project]"
      assert_select "input#asset_title[name=?]", "asset[title]"
      assert_select "textarea#asset_notes[name=?]", "asset[notes]"
      assert_select "input#asset_visible[name=?]", "asset[visible]"
    end
  end
end
