import QtQuick.Layouts 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import "."

Rectangle {
    id: mainMeasurePanel
    property var wheel1Value: 0
    property var wheel2Value: 0
    signal updateWheel1Value
    signal updateWheel2Value
    Layout.bottomMargin: 10
    Layout.leftMargin: 20
    color:"#404040"
    ColumnLayout {
        id: measurePanel
        anchors.fill: parent
        spacing: 10

        Text {
            id: introText
            color: "#ffffff"
            font.family: "Abel"
            font.pointSize: 20
            text: " 용존산소량 측정"
        }

        // Wheel 1
        RowLayout{
            spacing: 20

            Text {
                text: " 1 호지"
                color: "#ffffff"
                font.family: "Abel"
                font.pointSize: 20
            }

            Rectangle {
                id: rec1
                width: 150
                height: 40
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.minimumWidth: 100
                Layout.maximumWidth: 350
                color: "#404040"
                border.color: "#3467eb"
                border.width: 2
                radius: 5
                TextEdit {
                    id: valueWheel1

                    width: parent.width - 20
                    height: parent.height - 20
                    anchors.centerIn: parent
                    text: "0"
                    color: "#ffffff"

                    font.family: "Abel"
                    font.pointSize: 20
                    onTextChanged: {
                        wheel1Value = parseInt(valueWheel1.text)
                        console.debug("Wheel 1 Setup Value Changed: ", wheel1Value)

                        }
                    }
                }
             CustomButton{
                id: btWheel1
                text: ""
                width: 100
                height: 60
                onClicked: {
                    // handle button 1 click event
                    console.log("Update Wheel 1 measurement value to ", wheel1Value)
                    updateWheel1Value()
                }
             }
         }
         // Wheel 2
        RowLayout{
            spacing: 20
            Text {
                text: " 2 호지"
                color: "#ffffff"
                font.family: "Abel"
                font.pointSize: 20
             }
            Rectangle {
                id: rec2
                width: 150
                height: 40
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.minimumWidth: 100
                Layout.maximumWidth: 350
                color: "#404040"
                border.color: "#3467eb"
                border.width: 2
                radius: 5
                TextEdit {
                    id: valueWheel2
                    width: parent.width - 20
                    height: parent.height - 20
                    anchors.centerIn: parent
                    text: "0"
                    color: "#ffffff"
                    font.family: "Abel"
                    font.pointSize: 20

                    onTextChanged: {
                        wheel2Value = parseInt(valueWheel2.text)
                        console.debug("Wheel 2 Setup Value Changed: ", wheel2Value)

                    }
                }
            }
            CustomButton{
                id: btWheel2
                text: ""
                width: 100
                height: 60
                onClicked: {
                    console.log("Update Wheel 2 measurement value to ", wheel2Value)
                    updateWheel2Value()
                    }

                }

            }

        }
}
