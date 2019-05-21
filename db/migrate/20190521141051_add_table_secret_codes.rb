class AddTableSecretCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :secret_codes do |t|
      t.string :code, unique: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
