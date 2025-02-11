# 
#  game_object_spec.rb
#  binary_nights
#  
#  Created by Paulo Schneider on 2008-05-26.
#  Copyright 2008 Jeek Labs. All rights reserved.
# 

require File.dirname(__FILE__) + '/../spec_helper'

class TempObject < GameObject
  def initialize
    super()
  end
end

class StubGameObject < GameObject
  attr_writer :x, :y, :width, :height 
  
  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end
  
end

describe GameObject do
  
  it "should always have an initial value of 0" do
    temp_obj = TempObject.new
    temp_obj.x.should == 0
    temp_obj.y.should == 0
    temp_obj.width.should == 0
    temp_obj.height.should == 0
  end
  
  it "should have overrided values" do
    temp_obj = StubGameObject.new(10, 20, 30, 40)
    temp_obj.x.should == 10
    temp_obj.y.should == 20
    temp_obj.width.should == 30
    temp_obj.height.should == 40
  end
  
  describe "(setting values)" do
    
    it "should set object's placement" do
      temp_obj = TempObject.new
      temp_obj.at(10, 20)
      temp_obj.x.should == 10
      temp_obj.y.should == 20
    end
    
    it "should set object's dimension" do
      temp_obj = TempObject.new
      temp_obj.dimension(10, 20)
      temp_obj.width.should == 10
      temp_obj.height.should == 20
    end
    
    it "should set object's position and dimension through array" do
      temp_obj = TempObject.new
      temp_obj.set_from_array([10, 20, 30, 40])
      temp_obj.x.should == 10
      temp_obj.y.should == 20
      temp_obj.width.should == 30
      temp_obj.height.should == 40
    end
    
  end
  
  describe "(collisions)" do
    
    it "should not collide when not intersecting an object" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(100, 100, 20, 20)
      temp_obj1.collide?(temp_obj2).should == false
      temp_obj2.collide?(temp_obj1).should == false
    end

    it "should collide with itself" do
      temp_obj = StubGameObject.new(10, 10, 20, 20)
      temp_obj.collide?(temp_obj).should == true
    end

    it "should collide when intersecting through the left/right" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(20, 20, 50, 5)
      temp_obj1.collide?(temp_obj2).should == true
      temp_obj2.collide?(temp_obj1).should == true
    end

    it "should collide when intersecting through the left-top corner/right-bottom corner" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(20, 20, 50, 50)
      temp_obj1.collide?(temp_obj2).should == true
      temp_obj2.collide?(temp_obj1).should == true
    end

    it "should collide when intersecting through the top/bottom" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(20, 5, 5, 50)
      temp_obj1.collide?(temp_obj2).should == true
      temp_obj2.collide?(temp_obj1).should == true
    end

    it "should collide when intersecting through the right-top corner/left-bottom corner" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(20, 5, 30, 30)
      temp_obj1.collide?(temp_obj2).should == true
      temp_obj2.collide?(temp_obj1).should == true
    end 

    it "should collide when an object encompasses the other" do
      temp_obj1 = StubGameObject.new(10, 10, 20, 20)
      temp_obj2 = StubGameObject.new(5, 5, 100, 100)
      temp_obj1.collide?(temp_obj2).should == true
      temp_obj2.collide?(temp_obj1).should == true
    end 
    
  end
    
end
