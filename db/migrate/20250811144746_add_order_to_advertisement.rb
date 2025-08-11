class AddOrderToAdvertisement < ActiveRecord::Migration[8.0]
  def change
    add_column :advertisements, :order, :integer
  end
end
