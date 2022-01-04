class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :category, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
