class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :number
      t.string :status
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
