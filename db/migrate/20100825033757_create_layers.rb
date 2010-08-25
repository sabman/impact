class CreateLayers < ActiveRecord::Migration
  def self.up
    create_table :layers do |t|
      t.string :name
      t.text :description
      t.string :data_format
      t.string :workspace
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :layers
  end
end
