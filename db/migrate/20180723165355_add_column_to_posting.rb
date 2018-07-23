class AddColumnToPosting < ActiveRecord::Migration[5.0]
  def change
    add_column :postings, :date, :string
  end
end
