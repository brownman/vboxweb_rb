class CreateImports < ActiveRecord::Migration
  def self.up
    create_table :imports do |t|
      t.string :filepath
      t.string :status
      t.integer :percent_imported
      t.string :machine_uuid

      t.timestamps
    end
  end

  def self.down
    drop_table :imports
  end
end
