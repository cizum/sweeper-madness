#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QTranslator>
#include <QQmlEngine>

class Translator : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(QString up READ up NOTIFY upChanged)

public:
    explicit Translator(QQmlEngine* engine);

    QString language() const;
    QString up() const;

signals:
    void languageChanged(QString language);
    void upChanged(QString up);

public slots:
    void setLanguage(QString language);

private:
    QTranslator* m_translator;
    QString m_language;
    QQmlEngine* m_engine;
};

#endif // TRANSLATOR_H
