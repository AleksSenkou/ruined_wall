require_relative '../composition'

class Composition::Scene
  include Composition

  BLOCKS_COUNT = 6
  RECTANGLES_COUNT = 8

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
    reset_view

    draw_wall

    glutSwapBuffers
  end

  def draw_wall
    BLOCKS_COUNT.times do |block|
      RECTANGLES_COUNT.times do |rectangle|
        if block == 0 and rectangle == 0
          glTranslatef -2.1, 1.5, -6.0
        else
          glTranslatef 0.612, 0.0, 0.0
        end

        draw_rectangle
      end

      glTranslatef -4.895, -0.61, 0.0
    end
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

  def reset_view
    # Clear the screen and depth buffer
    glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT

    # Reset the view
    glMatrixMode GL_MODELVIEW
    glLoadIdentity
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
