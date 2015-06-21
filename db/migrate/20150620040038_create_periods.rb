class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.belongs_to :listing, index: true
      t.date :start
      t.date :end

      t.timestamps null: false
    end
    add_foreign_key :periods, :listings
  end
end
