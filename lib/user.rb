class User < CouchRest::Model::Base
  use_database $COUCH.default_database

  property :uid
  property :name
  property :nickname
  property :slug
  property :profile_image
  timestamps!
  
  design do 
    view :by_uid
  end
  
  # save_callback :before, :generate_slug_from_nickname

  def generate_slug_from_nickname
    unless self.slug
      self.slug = nickname.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^-|-$/,'') if new?
    end
  end
end