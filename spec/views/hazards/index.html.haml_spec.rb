require 'spec_helper'

describe "hazards/index.html.haml" do
  before(:each) do
    assign(:hazards, [
      stub_model(Hazard),
      stub_model(Hazard)
    ])
  end

  it "renders a list of hazards" do
    render
  end
end
