require 'spec_helper'

describe "hazards/show.html.haml" do
  before(:each) do
    @hazard = assign(:hazard, stub_model(Hazard))
  end

  it "renders attributes in <p>" do
    render
  end
end
