import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root

    Text {
        id: cropRatioText
        text: "Crop Size"

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    ComboBox {
        model: ["One", "Two", "Three"]

        anchors.left: cropRatioText.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
}
