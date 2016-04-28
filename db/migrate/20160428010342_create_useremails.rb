class CreateUseremails < ActiveRecord::Migration
  def change
    create_table :useremails do |t|
      t.string :name
      t.string :email
      t.string :login

      t.timestamps
    end
  end
end
