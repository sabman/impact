require 'spec_helper'

describe "exposures/new.html.haml" do
  before(:each) do
    assign(:exposure, stub_model(Exposure,
      :new_record? => true
    ))
  end

  it "renders new exposure form" do
    render

    rendered.should have_selector("form", :action => exposures_path, :method => "post") do |form|
    end
  end
end
