module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances_set!(arg)
      @instances ||= 0
      @instances += arg
    end

    def instances_get
      @instances
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances_set! 1
    end
  end
end

class Car
  include InstanceCounter

  def initialize
    register_instance
  end
end

p Car.instances_get

Car.new
Car.new
Car.new

p Car.instances_get

car = Car.new
p car.methods
