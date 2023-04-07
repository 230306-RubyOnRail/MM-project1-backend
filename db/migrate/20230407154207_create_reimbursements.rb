class CreateReimbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :reimbursements do |t|
      t.string :description
      t.string :status
      t.float :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
