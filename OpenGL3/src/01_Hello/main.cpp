#include <GLFW/glfw3.h>

typedef void (*GL_GENBUFFERS) (GLsizei, GLuint*); // 定义函数原型

GL_GENBUFFERS glGenBuffers = (GL_GENBUFFERS)glfwGetProcAddress("glGenBuffers"); // 找到正确的函数并赋值给函数指针

GLuint buffer;
glGenBuffers(1, &buffer);