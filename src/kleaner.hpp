#pragma once

#include <QObject>

class Kleaner : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString introductionText READ introductionText WRITE setIntroductionText NOTIFY introductionTextChanged)

    public:
        explicit Kleaner (QObject* parent = nullptr);
            QString introductionText() const;
            void setIntroductionText(const QString &introductionText);
            Q_SIGNAL void introductionTextChanged();
    
    private:
        QString m_introductionText = "Hello World!";
};