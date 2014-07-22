class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.integer :actor_id
      t.integer :subject_id
      t.string :subject_type
      t.text :notes

      t.timestamps
    end
  end
end
