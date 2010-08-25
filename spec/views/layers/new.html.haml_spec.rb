require 'spec_helper'

describe "layers/new.html.haml" do
  before(:each) do
    assign(:layer, stub_model(Layer,
      :new_record? => true,
      :name => "MyString",
      :description => "MyText",
      :file => "",
      :data_format => "MyString",
      :workspace => "MyString",
      :category => "MyString"
    ))
  end

  it "renders new layer form" do
    render

    rendered.should have_selector("form", :action => layers_path, :method => "post") do |form|
      form.should have_selector("input#layer_name", :name => "layer[name]")
      form.should have_selector("textarea#layer_description", :name => "layer[description]")
      form.should have_selector("input#layer_file", :name => "layer[file]")
      form.should have_selector("input#layer_data_format", :name => "layer[data_format]")
      form.should have_selector("input#layer_workspace", :name => "layer[workspace]")
      form.should have_selector("input#layer_category", :name => "layer[category]")
    end
  end
end
