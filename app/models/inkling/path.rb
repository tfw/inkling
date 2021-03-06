#an associated object which tracks all the relative URL paths to content in the system

class Inkling::Path < ActiveRecord::Base
  include Inkling::Util::Slugs
  
  set_table_name :inkling_paths

  belongs_to :content, :polymorphic => true
  has_many :permissions
  belongs_to :parent, :class_name => "Path"
  has_many :children, :class_name => "Path", :foreign_key => "parent_id"

  before_validation :update_slug!# , :unless => "self.new_record?"
  validate :slug_unique?


  #called before adding a new child path to see if the content object restricts what it's path should nest
  #if there isn't a restricts() impl. on the content object, false is returned, allowing anything to be nested
  def restricts?(sub_path)
    if self.content
      self.content.restricts?(sub_path.content) if self.content.respond_to? :restricts?
    else
      false
    end
  end

  #this method looks at the content object in case it wants to decide how to update the slug, otherwise
  #it uses a sluggerize transformation on the title of the content object
  def update_slug!
    if self.content.respond_to? :generate_path_slug
      self.slug = self.content.generate_path_slug
    else
      slug = self.parent ? "#{self.parent.slug}/" : "/"
      slug += "#{self.content.title}"
      self.slug = sluggerize(slug)
    end
  end

  def slug_unique?
    pre_existing = Inkling::Path.find_by_slug(self.slug)

    if pre_existing and (self.new_record? or (pre_existing.id != self.id))
      self.errors.add("path (#{self.slug}) already taken by another object in this website ")
    end
  end
end
