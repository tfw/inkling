class Inkling::Log < ActiveRecord::Base
  set_table_name 'inkling_logs'
  
  belongs_to :user, :class_name => "Inkling::User", :foreign_key => :user_id
  
  validates_presence_of :type
  validates_presence_of :text  

  SYSTEM = "inkling system"
end