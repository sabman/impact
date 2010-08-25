require 'spec_helper'

describe "exposures/show.html.haml" do
  before(:each) do
    @exposure = assign(:exposure, stub_model(Exposure))
  end

  it "renders attributes in <p>" do
    render
  end
end
