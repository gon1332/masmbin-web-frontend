class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.text :assembly_source
      t.text :binary
      t.string :name

      t.timestamps null: false
    end
  end
end
