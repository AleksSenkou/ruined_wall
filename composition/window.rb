require_relative '../composition'

class Composition::Window
  include Composition

  attr_reader :width, :height, :base

  def initialize(width: 640, height: 480)
    @width = width
    @height = height
  end

  def prepare
    glutInitWindowSize width, height
    glutInitWindowPosition 0, 0

    @base = glutCreateWindow NAME
  end

  def fullscreen
    glutFullScreen
  end
end
