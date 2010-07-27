class CreateHazards < ActiveRecord::Migration
  def self.up
    create_table :hazards do |t|
      t.string :name
      t.string :title
      t.string :workspace
      t.text :description
      t.string :service_url

      t.timestamps
    end
  end

  def self.down
    drop_table :hazards
  end
end
