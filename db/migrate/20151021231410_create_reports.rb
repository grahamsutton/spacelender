class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.belongs_to :listing, index: true
      t.text :reason

      t.timestamps null: false
    end
    add_foreign_key :reports, :listings
  end
end
