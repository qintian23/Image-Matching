#include <GLFW/glfw3.h>

typedef void (*GL_GENBUFFERS) (GLsizei, GLuint*); // ���庯��ԭ��

GL_GENBUFFERS glGenBuffers = (GL_GENBUFFERS)glfwGetProcAddress("glGenBuffers"); // �ҵ���ȷ�ĺ�������ֵ������ָ��

GLuint buffer;
glGenBuffers(1, &buffer);