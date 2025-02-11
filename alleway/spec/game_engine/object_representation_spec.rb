require File.dirname(__FILE__) + '/../spec_helper'

describe Engine::ObjectRepresentation do
  
  it "should execute registered update event" do
    was_updated = false

    representation = Engine::ObjectRepresentation.new(nil, nil)
    representation.always { was_updated = true }
    representation.update
    
    was_updated.should be_true
  end
  
end