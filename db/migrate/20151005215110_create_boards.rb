class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :state
      t.integer :turn
      t.integer :player
      t.string :legal_moves
      t.string :best_move

      t.timestamps null: false
    end
  end
end
