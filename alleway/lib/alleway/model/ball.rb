Velocity = Struct.new(:x, :y) do
  def adjust(radian)
    xl = Math::cos(radian)*self.x - Math::sin(radian)*self.y
    yl = Math::sin(radian)*self.x + Math::cos(radian)*self.y
    self.x = xl
    self.y = yl
  end
end

class Ball < Engine::GameObject
  
  attr_reader :velocity
  
  def initialize(config, *deflectors)
    configure_with(config)
    @deflectors = deflectors.flatten
    
    @speed = 5
    @velocity = Velocity.new(0.0, 1.0)
    @velocity.adjust(-0.2)
  end
    
  def move
    @deflectors.each { |deflector| deflector.deflect_and_adjust(self) }
    @x += @speed * @velocity.x
    @y += @speed * @velocity.y
  end

  def add_deflector(deflector)
    @deflectors << deflector
  end
  
  def remove_deflector(deflector)
    @deflectors.delete(deflector)
  end
  
end