import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "Customs"

ApplicationWindow {
    id: mainWindow
    width: 512
    height: 640
    visible: true
    title: "1 - GGuides"
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    signal addTask(string task)



    background: Rectangle {

        id: bg
        width: parent.width - 12
        height: parent.height - 12
        layer.enabled: true
        color: "white"

        layer.effect: DropShadow {
            anchors.fill: bg
            verticalOffset: 0
            horizontalOffset: 0
            radius: 7
            samples: 15
            color: Qt.rgba(0, 0, 0, 0.7)
            source: bg
        }
    }

    Rectangle {
        id: usable_content
        width: bg.width
        height: bg.height

        ColumnLayout {

            anchors.centerIn: parent
            width: parent.width
            height: parent.height

            // Title Bar
            Rectangle {
                z: 77777777777777
                id: title_bar
                anchors.top: parent.top
                Layout.fillWidth: true
                height: 30

                RowLayout {
                    width: parent.width
                    height: 30

                    Row {
                        height: 30

                        CustomButton {
                            height: parent.height
                            text: "\uE948"

                            onPressed: {
                                popup.open()
                            }

                        }

                    }


                    Row {
                        anchors.right: parent.right
                        height: 30

                        CustomButton {
                            height: parent.height
                            text: "\uE949"

                            onPressed: {
                                mainWindow.showMinimized()
                            }

                        }

                        CustomButton {
                            height: parent.height
                            text: "\uE711"
                            hover_bg: "red"

                            onPressed: {
                                mainWindow.close()
                            }

                        }

                    }

                }

            }

            // Listview
            ListView {
                id: view
                anchors.top: title_bar.bottom
                width: usable_content.width
                height: usable_content.height - title_bar.height
                spacing: 4

                signal appendTask(string task)

                onAppendTask: {
                    view.model.append([{'title': task}])
                }

                model: ListModel { ListElement {title: "Love"} ListElement {title: "Love"} }
                delegate: Delegate {}

            }

            PopUp {
                id: popup
            }

        }

    }

}
