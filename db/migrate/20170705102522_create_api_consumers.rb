class CreateApiConsumers < ActiveRecord::Migration[5.1]
  def change
    create_table :api_consumers do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
