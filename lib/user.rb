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

class Post < CouchRest::Model::Base
  use_database $COUCH.default_database

  property :uid # User ID who posted it
  property :pid # Post ID
  property :url # Page URL, stripped of weird string stuff when possible.
  property :full_url
  property :reddit_url # Reddit Resource Link
  timestamps!
  
  design do 
    view :by_pid
  end
  
  def clear_url
    # if self.slug has weird date related querystring info 
    #   save it without it
    # end
  end
  
end

