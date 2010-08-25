require 'spec_helper'

describe "hazards/new.html.haml" do
  before(:each) do
    assign(:hazard, stub_model(Hazard,
      :new_record? => true
    ))
  end

  it "renders new hazard form" do
    render

    rendered.should have_selector("form", :action => hazards_path, :method => "post") do |form|
    end
  end
end
