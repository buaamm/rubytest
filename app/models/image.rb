class Image < ActiveRecord::Base

  belongs_to :album
  has_attached_file :picture,
      :styles => { :large => "450x450>", :medium => "300x300>", :small => "100x100>" }
      #:path => ":rails_root/public/images/:id/:filename",
      #:url  => "/images/:id/:filename"
  # validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :picture
end
