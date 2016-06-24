module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class methods shows and calculates the number of object
  module ClassMethods
    def instances_set!(arg)
      @instances ||= 0
      @instances += arg
    end

    def instances_get
      @instances
    end
  end

  # Instance methods counts the number of objects
  module InstanceMethods
    def register_instance
      self.class.instances_set! 1
    end

    private :register_instance
  end
end
