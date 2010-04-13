require 'rubygems'
require 'uuidtools'
 
module UUIDHelper
  def before_create()
    self.uuid = make_uuid(self.class)
  end
  
  def make_uuid(target_class)
    uuid = UUIDTools::UUID.timestamp_create.to_s
    return uuid if target_class.find_by_uuid(self.uuid).nil?
    return make_uuid(target_class)
  end
end