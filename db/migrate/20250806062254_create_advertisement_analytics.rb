class CreateAdvertisementAnalytics < ActiveRecord::Migration[8.0]
  def change
    create_table :advertisement_analytics, id: :uuid do |t|
      t.uuid :advertisement_id, null: false  # Foreign key
      t.string :ip_address
      t.string :user_agent
      t.string :referrer
      t.string :requested_url
      t.string :query_parameters
      t.string :session_id

      t.timestamps
    end

    add_foreign_key :advertisement_analytics, :advertisements, column: :advertisement_id, primary_key: :id 
    add_index :advertisement_analytics, :advertisement_id
  end
end
