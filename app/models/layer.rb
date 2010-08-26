class Layer < ActiveRecord::Base
  has_attached_file :raw_data, :styles => {:original => {:a => :b }}, :processors => [:csv], :url => "/system/raw_datas/:id/:style/:basename.json"
end
