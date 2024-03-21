#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char** argv)
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.loadFromModule("io.github.najepaliya.kleaner", "Main");
    return app.exec();
}
