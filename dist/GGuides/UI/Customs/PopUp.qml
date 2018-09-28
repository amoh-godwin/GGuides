import QtQuick 2.10
import QtQuick.Controls 2.3
//import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Dialog {
    x: parent.width / 2 - (width / 2)
    y: parent.height / 2 - (height / 2)
    width: 256
    height: 160
    modal: false
    focus: true

    standardButtons: Dialog.Save | Dialog.Cancel

    background: Rectangle {
        id: rect
        width: parent.width
        height: parent.height
        layer.enabled: true

        layer.effect: DropShadow {
            anchors.fill: rect
            verticalOffset: 0
            horizontalOffset: 0
            radius: 48
            samples: 97
            color: Qt.rgba(0, 0, 0, 0.4)
            source: rect
        }

    }

    TextField {
        id: text_field
        font.pixelSize: 14
        anchors.centerIn: parent
        placeholderText: "Task name"
    }

    onAccepted: manager.add(text_field.text)

}
