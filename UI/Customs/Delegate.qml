import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


Component {

    SwipeDelegate {
        id: ctrl
        width: parent.width
        height: 52
        leftPadding: 40
        rightPadding: 64
        font.pixelSize: 12
        text: title

        property color ongoing_color: "#e1e1e1"
        property color accent: "#F7630C"

        background: Rectangle {
            width: parent.width
            color: "white"

            RowLayout {
                width: parent.width
                height: parent.height

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 16
                    radius: 2
                    color: ongoing ? accent : ctrl.ongoing_color
                }

                Button {
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    text: "Done"

                    background: Rectangle {
                        implicitWidth: 52
                        implicitHeight: 24
                        radius: 2
                        border.color: Qt.rgba(0, 0, 0, 0.1)
                    }

                    contentItem: Text {
                        font: parent.font
                        text: parent.text
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: accent
                    }

                    onClicked: {
                        manager.finish(index)
                        view.model.remove(index, 1)
                    }

                }

            }

        }

        contentItem: Text {
            font: parent.font
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            color: accent
        }

        swipe.right: Row {
            anchors.right: parent.right

            Label {
                text: ongoing ? "Has started" : "Start"
                width: 68
                height: 52
                color: "white"
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: accent
                }
                
                SwipeDelegate.onClicked: {

                    swipe.close()
                    manager.set_ongoing(index)
                    view.model.move(index, 0, 1)
                    view.model.setProperty(index, 'ongoing', true)
                }
                
            }

            Label {
                text: "remove"
                width: 64
                height: 52
                color: "white"
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter

                background: Rectangle {
                    color: "red"
                }

                SwipeDelegate.onClicked: {

                    swipe.close()
                    manager.remove(index)
                    view.model.remove(index, 1)
                }

            }
        }

    }

}
