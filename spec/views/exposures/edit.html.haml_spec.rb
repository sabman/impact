require 'spec_helper'

describe "exposures/edit.html.haml" do
  before(:each) do
    @exposure = assign(:exposure, stub_model(Exposure,
      :new_record? => false
    ))
  end

  it "renders the edit exposure form" do
    render

    rendered.should have_selector("form", :action => exposure_path(@exposure), :method => "post") do |form|
    end
  end
end
