class CreateAdvertisementPointers < ActiveRecord::Migration[8.0]
  def change
    create_table :advertisement_pointers do |t|
      t.integer :last_order

      t.timestamps
    end
  end
end
