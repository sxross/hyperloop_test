class CreateHyperloopTables < ActiveRecord::Migration[5.1]
  def change
    create_table "hyperloop_connections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "channel"
      t.string "session"
      t.datetime "created_at"
      t.datetime "expires_at"
      t.datetime "refresh_at"
    end

    create_table "hyperloop_queued_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.text "data"
      t.integer "connection_id"
    end
  end
end
