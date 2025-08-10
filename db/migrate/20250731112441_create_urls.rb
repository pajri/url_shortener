class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls, id: uuid do |t|
      t.string :long_url
      t.string :short_url
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
