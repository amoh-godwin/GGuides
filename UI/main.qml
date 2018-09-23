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

    property color accent: "#F7630C"

    Component.onCompleted: manager.start()

    Component.onDestruction: {
        var cc = view.model.count
        var items = []
        for (var i = 0; i < cc; i++) {
            items.push(view.model.get(i))
        }
        console.log(items)

    }

    signal addTask(var task)

    onAddTask: {
        view.model.append(task)
    }



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
        color: "#f2f2f2"

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
                color: "#F7630C"

                property int prevX
                property int prevY

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        parent.prevX = mouseX
                        parent.prevY = mouseY
                    }

                    onMouseXChanged: {
                        var change = mouseX - parent.prevX
                        mainWindow.setX(mainWindow.x + change)

                    }

                    onMouseYChanged: {
                        var change = mouseY - parent.prevY
                        mainWindow.setY(mainWindow.y + change)

                    }
                }

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
                            //width: 40
                            height: parent.height
                            text: "\uE711"
                            hover_bg: "red"
                            hover_cl: "white"

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

                model: ListModel {}
                delegate: Delegate {}

            }

            PopUp {
                id: popup
            }

        }

    }

    Connections {
        target: manager

        onSend_first: {
            var result = _start
            addTask(result)
        }

        onAdd_t: {
            var result = _add
            addTask(result)
        }

    }
}
