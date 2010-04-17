class CreateExports < ActiveRecord::Migration
  def self.up
    create_table :exports do |t|
      t.string :machine_id
      t.string :export_data
      t.string :status
      t.integer :percent_exported

      t.timestamps
    end
  end

  def self.down
    drop_table :exports
  end
end
