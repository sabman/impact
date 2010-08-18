require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require "app/models/hazard.rb"

describe Hazard do
  it "should return all availalbe layers" do
    Hazard.layers.should.include({ :name => "l1", :url => "url"})
  end
end

# == Schema Information
#
# Table name: hazards
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  service_url :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

