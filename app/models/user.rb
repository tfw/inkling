#this is a dummy class to be overridden by the hosting app.
#engine classes can be overridden.

class User < ActiveRecord::Base
  acts_as_inkling_user
end