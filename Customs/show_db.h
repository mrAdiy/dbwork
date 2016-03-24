#ifndef SHOW_DB_H
#define SHOW_DB_H

#include <QDialog>
#include <QTableWidget>

#include "inquiry_handler.h"

namespace Ui {
class Show_DB;
}

class Show_DB : public QDialog
{
    Q_OBJECT

public:
    explicit Show_DB(QWidget *parent = 0);
    ~Show_DB();
    void addRow();
    void fillRow(inquiry_handler IHshow, int i);
    void fillTable(int page);

private:
    Ui::Show_DB *ui;
    std::vector<QString> BD_data;
    int rows_counter;

private slots:
    void set_displayed_page();
};

#endif // SHOW_DB_H
