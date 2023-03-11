// xlsxcelllocation.cpp

#include <QtGlobal>
#include <QObject>
#include <QString>
#include <QVector>
#include <QList>

#include "header/xlsxglobal.h"
#include "header/xlsxcell.h"
#include "header/xlsxcelllocation.h"

QT_BEGIN_NAMESPACE_XLSX

CellLocation::CellLocation()
{
    col = -1;
    row = -1;

    cell.reset();
}

QT_END_NAMESPACE_XLSX
