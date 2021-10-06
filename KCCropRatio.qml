import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml.Models 2.12

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
        textRole: "text"
        valueRole: "value"

        model: ListModel {
            id: model
            ListElement { value: 1; text: "Free size" }
            ListElement { value: 2; text: "Full HD (1920x1080)" }
            ListElement { value: 3; text: "WUXGA (1920x1200)" }
        }

        delegate: ItemDelegate {
            id: itemDelegate
            contentItem: Text { text: model.text }
        }

        onActivated: {console.log(currentValue);}

        anchors.left: cropRatioText.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
}
