require_relative 'company'
require_relative 'instance_counter'

class Carriage
  include Company
  include InstanceCounter
end
