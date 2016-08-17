class InitDb < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.attachment :image
      t.integer :user_id, index: true, foregin_key: true
      t.timestamps
    end

    create_table :transactions do |t|

      t.integer :seller_id, index: true, foreign_key: true
      t.integer :buyer_id, index: true, foreign_key: true
      t.integer :listing_id, index: true, foreign_key: true
      t.integer :points, null: false, default: 0
      t.string :serial_number, null: false
      t.integer :room_id, index: true

      t.timestamps null: false
    end

    create_table :rooms do |t|
      t.integer :seller_id, foreign_key: true, index: true
      t.integer :buyer_id, foreign_key: true, index: true
      t.integer :listing_id, foreign_key: true, index: true
      t.integer :messages_count, default: 0
      t.timestamps null: false
    end

    create_table :messages do |t|
      t.integer :room_id, foreign_key: true, index: true
      t.text :message
      t.string :sender_name

      t.timestamps null: false
    end

    create_table :archives do |t|

      t.integer :seller_id, index: true, foreign_key: true
      t.integer :buyer_id, index: true, foreign_key: true
      t.integer :listing_id, index: true, foreign_key: true
      t.integer :points, null: false, default: 0
      t.string  :serial_number, null: false
      t.integer :room_id, index: true
      t.timestamps null: false
    end

    create_table(:users) do |t|
      ## Database authenticatable
      t.string :name
      t.integer :points,            null: false, default: 1
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :interests

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

  end
end
