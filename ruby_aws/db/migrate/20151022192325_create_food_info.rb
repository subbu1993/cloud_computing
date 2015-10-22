class CreateFoodInfo < ActiveRecord::Migration
  def change
    create_table :food_infos do |t|
      t.string :name
    end
  end
end
