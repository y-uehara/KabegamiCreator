import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root
    property int brightness: 100

    Text {
        id: brightnessText
        text: "Brightness"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
    Slider {
        id: slider
        from: 0
        to: 100
        value: brightness

        anchors.left: brightnessText.right
        anchors.right: percentText.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        onMoved: {
            brightness = value;
        }

        onPressedChanged: {
            if(!slider.pressed) {
                kcImageCanvas.setBrightness(brightness);
            }
        }
    }
    Text {
        id: percentText
        text: brightness + "%"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
