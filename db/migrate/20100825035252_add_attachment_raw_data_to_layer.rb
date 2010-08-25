class AddAttachmentRawDataToLayer < ActiveRecord::Migration
  def self.up
    add_column :layers, :raw_data_file_name, :string
    add_column :layers, :raw_data_content_type, :string
    add_column :layers, :raw_data_file_size, :integer
    add_column :layers, :raw_data_updated_at, :datetime
  end

  def self.down
    remove_column :layers, :raw_data_file_name
    remove_column :layers, :raw_data_content_type
    remove_column :layers, :raw_data_file_size
    remove_column :layers, :raw_data_updated_at
  end
end
