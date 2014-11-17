/*
	Author: Marco Costalba (C) 2005-2007

	Copyright: See COPYING file that comes with this distribution

*/
#ifndef REVSVIEW_H
#define REVSVIEW_H

#include <QScopedPointer>
#include "ui_revsview.h" // needed by moc_* file to understand tab() function
#include "common.h"
#include "domain.h"

class MainImpl;
class Git;
class FileHistory;
class PatchView;

class RevsView : public Domain
{
    Q_OBJECT
public:
    RevsView(MainImpl* parent, GitSharedPtr git, bool isMain = false);
    ~RevsView();
    void clear(bool complete);
    void viewPatch(bool newTab);
    void setEnabled(bool b);
    void setTabLogDiffVisible(bool);
    QTextEdit* log()  {return static_cast<QTextEdit*>(this->tab()->textBrowserDesc);}
    QTextEdit* diff() {return static_cast<QTextEdit*>(this->tab()->textEditDiff);}
    void onKeyUp(){tab()->listViewLog->on_keyUp();}
    void onKeyDown(){tab()->listViewLog->on_keyDown();}
private:
    Ui_TabRev* tab() { return revTab.data(); }

public slots:
    void toggleDiffView();

private slots:
    void on_newRevsAdded(const FileHistory*, const QVector<ShaString>&);
    void on_loadCompleted(const FileHistory*, const QString& stats);
    void on_lanesContextMenuRequested(const QStringList&, const QStringList&);
    void on_updateRevDesc();

protected:
    virtual bool doUpdate(bool force);

private:
    friend class MainImpl;

    void updateLineEditSHA(bool clear = false);

    QScopedPointer<Ui_TabRev> revTab;
    QScopedPointer<PatchView,QScopedPointerDeleteLater> linkedPatchView;
};

#endif
