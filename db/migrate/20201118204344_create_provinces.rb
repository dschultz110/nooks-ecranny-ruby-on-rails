class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :pst
      t.references :gst, null: false, foreign_key: true
      t.references :hst, null: false, foreign_key: true

      t.timestamps
    end
  end
end
