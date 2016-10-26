require_relative '../composition'
require_relative 'window'
require_relative 'keyboard'
require_relative 'scene'

class Composition::Client
  include Composition

  attr_reader :window, :keyboard, :scene

  def initialize(width:, height:)
    @window = Composition::Window.new(width: width, height: height)
    @keyboard = Composition::Keyboard.new
    @scene = Composition::Scene.new(window: window)

    prepare_composition
  end

  def prepare_composition
    glutInit

    window.prepare
    keyboard.prepare_for(window: window.base)
    scene.prepare
  end

  def draw!
    scene.draw

    glutMainLoop
  end
end
