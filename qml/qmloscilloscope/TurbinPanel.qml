import QtQuick.Layouts 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import "."

Rectangle {
    id: recList1
    width: 1010
    height: 70
    Layout.fillWidth: true
    Layout.preferredHeight: 70
    Layout.minimumWidth: 100
    Layout.maximumWidth: 1010

    color: "#404040"
    border.color: "#3467eb"
    border.width: 2
    radius: 5
    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: 100
        cellHeight: 50
        anchors {
                    fill: parent
                    leftMargin: 10
                }

        model: ListModel {
            id: itemModel
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
            ListElement {
                imagePath: "qrc:/source/image/turbin_on.png"
            }
        }
        delegate: Image {
            source: model.imagePath
            fillMode: Image.PreserveAspectFit
        }
    }
 }
