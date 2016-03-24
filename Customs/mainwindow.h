#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QVBoxLayout>

#include "qcustomplot.h"
#include "show_db.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    QCustomPlot *gist;
    QCPBars *fossil;

    void MakeGist();
    double getValueFromTable(int row_number);

private slots:
    void handle_AcceptButton();
    void handle_upd_button();
    void rewriteGist();
    void main_show_DB();
    int getCriterium();
    void CallMessageBox(QString str);
    bool checkToInt();
};

#endif // MAINWINDOW_H
