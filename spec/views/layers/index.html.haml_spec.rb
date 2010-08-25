require 'spec_helper'

describe "layers/index.html.haml" do
  before(:each) do
    assign(:layers, [
      stub_model(Layer,
        :name => "Name",
        :description => "MyText",
        :file => "",
        :data_format => "Data Format",
        :workspace => "Workspace",
        :category => "Category"
      ),
      stub_model(Layer,
        :name => "Name",
        :description => "MyText",
        :file => "",
        :data_format => "Data Format",
        :workspace => "Workspace",
        :category => "Category"
      )
    ])
  end

  it "renders a list of layers" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Data Format".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Workspace".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Category".to_s, :count => 2)
  end
end
