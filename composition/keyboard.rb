require_relative '../composition'

class Composition::Keyboard
  include Composition

  ESC = ?\e

  def prepare_for(window:)
    glutKeyboardFunc key_press_listner_for(window)
  end

  private

  def key_press_listner_for(window)
    lambda do |key, x, y|
      case key
      when ESC
        glutDestroyWindow window
        exit(0)
      end

      glutPostRedisplay
    end
  end
end
