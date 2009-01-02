module Consent
  class Rule
    
    def initialize(action, block)
      @action, @predicate = action, block
    end
    
    def check(context)
      applies?(context) ? context.instance_eval(&@predicate) : true
    end
    
  private
    
    def applies?(context)
      @action.matches?(context)
    end
    
  end
end

