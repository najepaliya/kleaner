#pragma once

#include <QtQml>
#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    public:
        explicit Backend(QObject* parent = nullptr);
        Q_INVOKABLE void generateNumber();
    
    signals:
        void numberEmitted(int num);
};