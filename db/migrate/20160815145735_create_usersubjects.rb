class CreateUsersubjects < ActiveRecord::Migration
  def change
    create_table :usersubjects do |t|
      t.integer :subject_id
      t.integer :user_id
      t.timestamps
    end
  end
end
