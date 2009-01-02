module Consent
  class Controller
    
    attr_reader :name
    
    def initialize(description, name)
      @description, @name = description, name.to_s
    end
    
    def controller_class
      Kernel.const_get("#{ @name.camelcase }Controller")
    end
    
    def method_missing(name, params = nil, &block)
      action = Action.new(self, name, params)
      @description.add_rule(action, &block) if block_given?
      action
    end
    
    def http_restrict(verb)
      controller_class.class_eval do
        verify  :method => verb,
                :render => DENIAL_RESPONSE
      end
    end
    
  end
end

