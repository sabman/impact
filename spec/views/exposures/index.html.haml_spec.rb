require 'spec_helper'

describe "exposures/index.html.haml" do
  before(:each) do
    assign(:exposures, [
      stub_model(Exposure),
      stub_model(Exposure)
    ])
  end

  it "renders a list of exposures" do
    render
  end
end
