#include "fileio.h"
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QTextStream>
#include <QDebug>
#include  <QtWidgets/QFileDialog>

FileIO::FileIO(QObject *parent)
    : QObject(parent)
    , m_source("")
    , m_content("")
    , m_folder("")
    , m_fileOpened(false)
    , m_isReading(false)
{

}

void FileIO::reloadFile()
{
    read();
}

QString FileIO::openFileDialog()
{
    return  QFileDialog::getOpenFileName(0, "","",tr("Files (*.*)"));
}

QString FileIO::saveAsFileDialog()
{
    return  QFileDialog::getSaveFileName(0,"","",tr("Files (*.*)"));
}

void FileIO::read()
{
    m_isReading = true;
    QString fileContent;
    m_fileOpened = false;
    if (!m_source.isEmpty())
    {
	QFile file(m_source);
	if ( file.open(QIODevice::ReadOnly) )
	{
	    QFileInfo info(file);
	    setFolder(info.absoluteDir().absolutePath());

	    QTextStream t( &file );
	    fileContent = t.readAll();
	    file.close();
	    m_fileOpened = true;
	}
    }

    setContent(fileContent);
    m_isReading = false;

    emit readingFile();
    emit fileOpenedChanged();
}

void FileIO::write(const QString& data)
{
    if (!m_source.isEmpty())
    {
	QFile file(m_source);

	if (!file.open(QFile::WriteOnly | QFile::Truncate))
	{
	    qDebug() << "failed to write content to file : "<< m_source;
	    return;
	}

	QTextStream out(&file);
	out << data;
	file.close();
    }
}

QString FileIO::source()     const { return m_source; }
QString FileIO::content()    const { return m_content;}
QString FileIO::folder()     const { return m_folder;}

bool    FileIO::fileOpened() const { return m_fileOpened; }

void FileIO::componentComplete()
{
    read();
}

void FileIO::setSource(const QString &new_source)
{
    if(m_source != new_source)
    {
	m_source = new_source;
	read();
	emit sourceChanged();
    }
}

void FileIO::setContent(const QString& new_content)
{
    if (m_content != new_content)
    {
	m_content = new_content;
	if(!m_isReading) write(m_content);
	emit contentChanged();

    }
}

void FileIO::setFolder(const QString& new_folder)
{
    if (m_folder != new_folder)
    {
	m_folder = new_folder;
	emit folderChanged();
    }
}
