#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QQmlParserStatus>

class FileIO : public QObject,public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
public:
    Q_PROPERTY(QString source  READ source  WRITE setSource  NOTIFY sourceChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(QString folder  READ folder                   NOTIFY folderChanged)
    Q_PROPERTY(bool    fileOpened READ fileOpened NOTIFY fileOpenedChanged)
    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE void reloadFile();
    Q_INVOKABLE QString openFileDialog();
    Q_INVOKABLE QString saveAsFileDialog();

    QString source() const;
    QString content() const;
    QString folder() const;
    bool fileOpened() const;

    virtual void classBegin(){};
    virtual void componentComplete();

public slots:
    void setSource(const QString& new_source);
    void setContent(const QString& new_content);
    void setFolder(const QString& new_folder);
signals:
    void sourceChanged();
    void contentChanged();
    void folderChanged();
    void fileOpenedChanged();
    void readingFile();

private:
    QString m_source;
    QString m_content;
    QString m_folder;
    bool m_fileOpened;
    bool m_isReading;


    void read();
    void write(const QString& data);

};

#endif // FILEIO_H
