/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Charts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtCharts 2.1

//![1]
ChartView {
    id: chartView
    animationOptions: ChartView.NoAnimation
    theme: ChartView.ChartThemeDark
    property bool openGL: true
    property bool openGLSupported: true

    property double globalVariable_col: 0

    onOpenGLChanged: {
        if (openGLSupported) {
            series("발전량").useOpenGL = openGL;
            series("부하전력").useOpenGL = openGL;
        }
    }
    Component.onCompleted: {
        if (!series("발전량").useOpenGL) {
            openGLSupported = false
            openGL = false
        }
    }

    ValueAxis {
        id: axisY1
        min: 0
        max: 40
    }

    ValueAxis {
        id: axisY2
        min: 0
        max: 40
    }

    ValueAxis {
        id: axisX
        min: 0
        max: 24
    }

    LineSeries {
        id: lineSeries1
        name: "발전량"
        axisX: axisX
        axisY: axisY1
        useOpenGL: chartView.openGL
    }
    LineSeries {
        id: lineSeries2
        name: "부하전력"
        axisX: axisX
        axisYRight: axisY2
        useOpenGL: chartView.openGL
    }
//![1]

    function updateLineSeries(index) {
        setAnimations(true);
        lineSeries2.remove(0, lineSeries2.count - 1);
        console.log("count: " + lineSeries2.count)
        // update chart 1
        dataSource.update(chartView.series(0));
        var newData = [];
        // update chart 2
        for (var i = 0; i < 24; i++) {
            var x = i // get the current number of points in the series
            var y = dataSource.loadFromExcel(i+8,2+index)
            newData.push(x, y);
            //console.log("index: " + (2+index))
            lineSeries2.append(x, y) // append the new point to the series
        }
        //lineSeries2.replace(0, 24, newData);

    }

    //![2]
//    Timer {
//        id: refreshTimer
//        interval: 1 / 60 * 1000 // 60 Hz
//        running: true
//        repeat: true
//        onTriggered: {
//            dataSource.update(chartView.series(0));
//            for (var i = 0; i < 24; i++) {
//                var x = lineSeries2.count // get the current number of points in the series
//                var y = dataSource.loadFromExcel(i+8,2+globalVariable_col)
//                lineSeries2.append(x, y) // append the new point to the series
//            }
//        }
//    }
    //![2]    


    //![3]
    function changeSeriesType(type) {
        chartView.removeAllSeries();

        // Create two new series of the correct type. Axis x is the same for both of the series,
        // but the series have their own y-axes to make it possible to control the y-offset
        // of the "signal sources".
        if (type == "line") {
            var series1 = chartView.createSeries(ChartView.SeriesTypeLine, "발전량",
                                                 axisX, axisY1);
            series1.useOpenGL = chartView.openGL

            var series2 = chartView.createSeries(ChartView.SeriesTypeLine, "부하전력",
                                                 axisX, axisY2);
            series2.useOpenGL = chartView.openGL
        } else {
            var series1 = chartView.createSeries(ChartView.SeriesTypeScatter, "발전량",
                                                 axisX, axisY1);
            series1.markerSize = 2;
            series1.borderColor = "transparent";
            series1.useOpenGL = chartView.openGL

            var series2 = chartView.createSeries(ChartView.SeriesTypeScatter, "부하전력",
                                                 axisX, axisY2);
            series2.markerSize = 2;
            series2.borderColor = "transparent";
            series2.useOpenGL = chartView.openGL
        }
    }

    function createAxis(min, max) {
        // The following creates a ValueAxis object that can be then set as a x or y axis for a series
        return Qt.createQmlObject("import QtQuick 2.0; import QtCharts 2.0; ValueAxis { min: "
                                  + min + "; max: " + max + " }", chartView);
    }
    //![3]

    function setAnimations(enabled) {
        if (enabled)
            chartView.animationOptions = ChartView.SeriesAnimations;
        else
            chartView.animationOptions = ChartView.NoAnimation;
    }

    function changeRefreshRate(rate) {
        refreshTimer.interval = 1 / Number(rate) * 1000;
    }
}
