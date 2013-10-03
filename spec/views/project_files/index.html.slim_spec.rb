require 'spec_helper'

describe "project_files/index" do
  before(:each) do
    assign(:project_files, [
      stub_model(ProjectFile,
        :project => nil,
        :url => "Url",
        :data => ""
      ),
      stub_model(ProjectFile,
        :project => nil,
        :url => "Url",
        :data => ""
      )
    ])
  end

  it "renders a list of project_files" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
