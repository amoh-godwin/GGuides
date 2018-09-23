import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


Component {

    SwipeDelegate {
        width: parent.width
        height: 52
        leftPadding: 40
        rightPadding: 64
        text: title

        background: Rectangle {
            width: parent.width
            color: "#e1e1e1"

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
                    color: "dodgerblue"
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

                    onClicked: {
                        manager.finish(index)
                        view.model.remove(index, 1)
                    }

                }

            }

        }

        swipe.right: Row {
            anchors.right: parent.right

            Label {
                text: "Start"
                width: 64
                height: 52
                color: "white"
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "dodgerblue"
                }
                
                SwipeDelegate.onClicked: {

                    swipe.close()
                    manager.set_ongoing(index)
                    view.model.move(index, 0, 1)
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
