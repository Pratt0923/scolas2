class CreateEditinterests < ActiveRecord::Migration
  def change
    create_table :editinterests do |t|

      t.timestamps
    end
  end
end
