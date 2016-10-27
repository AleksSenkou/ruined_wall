require_relative '../composition'

class Composition::Scene
  include Composition

  attr_reader :window

  def initialize(window:)
    @window = window
  end

  def prepare
    # Setup a double buffer, RGBA color, alpha components and depth buffer
    glutInitDisplayMode GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH

    glutIdleFunc :idle
    glutDisplayFunc :draw
    glutReshapeFunc :reshape

    prepare_gl

    # http://nehe.gamedev.net/tutorial/your_first_polygon/13002/
  end

  def prepare_gl
    glClearColor 0.0, 0.0, 0.0, 0
    glClearDepth 1.0

    # Set type of depth test
    glDepthFunc GL_LEQUAL
    # Enable depth testing
    glEnable GL_DEPTH_TEST
    # Enable smooth color shading
    glShadeModel GL_SMOOTH

    glMatrixMode GL_PROJECTION
    glLoadIdentity

    calculate_aspect_ratio(window.width, window.height)

    glMatrixMode GL_MODELVIEW
  end

  def draw
    # Clear the screen and depth buffer
    glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT

    # Reset the view
    glMatrixMode GL_MODELVIEW
    glLoadIdentity

    # Move right 3 units
    glTranslatef 1.5, 0.0, -6.0

    draw_rectangle

    # Swap buffers for display
    glutSwapBuffers
  end

  private

  def draw_rectangle(step = 0.3)
    glBegin GL_QUADS do
      glVertex3f -step,  step, 0.0
      glVertex3f  step,  step, 0.0
      glVertex3f  step, -step, 0.0
      glVertex3f -step, -step, 0.0
    end
  end

  def reshape(width, height)
    height = 1 if height == 0

    # Reset current viewpoint and perspective transformation
    glViewport 0, 0, width, height

    glMatrixMode GL_PROJECTION
    glLoadIdentity

    calculate_aspect_ratio(width, height)
  end

  def calculate_aspect_ratio(width, height)
    gluPerspective 45.0, width / height, 0.1, 100.0
  end

  def idle
    glutPostRedisplay
  end
end
