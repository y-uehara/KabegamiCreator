import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml.Models 2.12

Item {
    id: root

    states: [
        State {
            when: ratioCombo.currentValue === 1
            PropertyChanges { target: xText; text: "X ratio" }
            PropertyChanges { target: xInput; readOnly: false }
            PropertyChanges { target: yText; text: "Y ratio" }
            PropertyChanges { target: yInput; readOnly: false }
        },
        State {
            when: ratioCombo.currentValue === 2
            PropertyChanges { target: xText; text: "Width" }
            PropertyChanges { target: xInput; readOnly: false }
            PropertyChanges { target: yText; text: "Height" }
            PropertyChanges { target: yInput; readOnly: false }
        },
        State {
            when: ratioCombo.currentValue === 3
            PropertyChanges { target: xText; text: "Width" }
            PropertyChanges { target: xInput; text: "1920"; readOnly: true }
            PropertyChanges { target: yText; text: "Height" }
            PropertyChanges { target: yInput; text: "1080"; readOnly: true }
        },
        State {
            when: ratioCombo.currentValue === 4
            PropertyChanges { target: xText; text: "Width" }
            PropertyChanges { target: xInput; text: "1920"; readOnly: true }
            PropertyChanges { target: yText; text: "Height" }
            PropertyChanges { target: yInput; text: "1200"; readOnly: true }
        },
        State {
            when: ratioCombo.currentValue === 5
            PropertyChanges { target: xText; text: "X ratio" }
            PropertyChanges { target: xInput; text: "4"; readOnly: true }
            PropertyChanges { target: yText; text: "Y ratio" }
            PropertyChanges { target: yInput; text: "3"; readOnly: true }
        }
    ]



    Text {
        id: cropRatioText
        text: "Crop Size"

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    ComboBox {
        id: ratioCombo
        width: parent.width * 0.25
        textRole: "explain"
        valueRole: "value"

        model: ListModel {
            id: model
            ListElement { value: 1; explain: "Set ratio" }
            ListElement { value: 2; explain: "Set size" }
            ListElement { value: 3; explain: "Full HD (1920x1080)" }
            ListElement { value: 4; explain: "WUXGA (1920x1200)" }
            ListElement { value: 5; explain: "4:3" }
        }

        delegate: ItemDelegate {
            id: itemDelegate
            contentItem: Text { text: explain }
        }

        onActivated: {console.log(currentValue);}

        anchors.left: cropRatioText.right
        //anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    Text {
        id: xText
        text: "X"

        anchors.left: ratioCombo.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    TextInput {
        id: xInput
        width: parent.width * 0.1

        verticalAlignment: Text.AlignVCenter

        anchors.left: xText.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
    Text {
        id: yText
        text: "Y"

        anchors.left: xInput.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    TextInput {
        id: yInput
        width: parent.width * 0.1

        verticalAlignment: Text.AlignVCenter

        anchors.left: yText.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
}
