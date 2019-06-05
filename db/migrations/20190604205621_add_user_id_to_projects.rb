Hanami::Model.migration do
  change do
    alter_table :projects do
      add_foreign_key :user_id, :users, on_delete: :cascade, null: false
      add_index :user_id
    end
  end
end
