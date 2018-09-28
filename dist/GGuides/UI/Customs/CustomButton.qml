import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: ctrl
    font.pixelSize: 14
    property color hover_bg: "white"
    property color hover_cl: accent

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 36
        color: ctrl.hovered ? hover_bg : "transparent"
    }

    contentItem: Text {
        font: ctrl.font
        text: ctrl.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: ctrl.hovered ? hover_cl : "white"
    }

}
