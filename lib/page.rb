# example model file
class Page
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :address,    String       # Need to make this unique
  property :created_by, String
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :address
  has n, :flags
end

class Flag
  include DataMapper::Resource
  
  property :id,         Serial
  property :page_id,    String
  property :flagged_by, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :page
end

# DataMapper.finalize
# DataMapper.update
