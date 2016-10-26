require 'require_all'

require_relative '../composition'
require_all Dir[File.dirname(__FILE__)]

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

  def start!
    scene.draw

    glutMainLoop
  end
end
