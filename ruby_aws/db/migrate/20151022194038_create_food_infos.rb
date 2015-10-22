class CreateFoodInfos < ActiveRecord::Migration
  def change
    create_table :food_infos do |t|

      t.timestamps
    end
  end
end
