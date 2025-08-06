class CreateAdvertisements < ActiveRecord::Migration[8.0]
  def change
    create_table :advertisements, id: :uuid do |t|
      t.string :label
      t.string :image_url

      t.timestamps
    end
  end
end
