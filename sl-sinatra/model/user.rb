class User
  include MongoMapper::Document

  key :name, String

  def self.by_name(name)
    self.where(:name => name).first
  end

end
