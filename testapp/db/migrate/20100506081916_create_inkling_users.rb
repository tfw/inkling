class CreateInklingUsers < ActiveRecord::Migration
  def self.up
    # create_table :inkling_users do |t|   see http://inkling.lighthouseapp.com/projects/52914-inkling/tickets/10-set_table_name-seems-to-be-broken-in-ar-for-rails-3-rc-1#ticket-10-2
    create_table :users do |t|
     t.string :login, :null => false
     t.string :email, :null => false
     t.integer :role_id
     t.string :display_name
     t.string :given_name
     t.string :family_name
     t.string :crypted_password, :null => false
     t.string :salt, :limit => 40
     t.datetime :last_seen
     t.string :ip
     t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
