require 'spec_helper'

describe "hazards/edit.html.haml" do
  before(:each) do
    @hazard = assign(:hazard, stub_model(Hazard,
      :new_record? => false
    ))
  end

  it "renders the edit hazard form" do
    render

    rendered.should have_selector("form", :action => hazard_path(@hazard), :method => "post") do |form|
    end
  end
end
