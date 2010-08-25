require 'spec_helper'

describe "layers/show.html.haml" do
  before(:each) do
    @layer = assign(:layer, stub_model(Layer,
      :name => "Name",
      :description => "MyText",
      :file => "",
      :data_format => "Data Format",
      :workspace => "Workspace",
      :category => "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("".to_s)
    rendered.should contain("Data Format".to_s)
    rendered.should contain("Workspace".to_s)
    rendered.should contain("Category".to_s)
  end
end
