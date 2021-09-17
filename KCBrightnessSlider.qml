import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root

    Text {
        id: brightnessText
        text: "Brightness"
        anchors.left: root.left
        anchors.verticalCenter: root.verticalCenter
    }
    Slider {
        id: slider
        from: 0
        to: 100
        value: app.brightness

        anchors.left: brightnessText.right
        anchors.right: percentText.left
        anchors.top: root.top
        anchors.bottom: root.bottom

        onMoved: {
            app.brightness = value;
        }

        onPressedChanged: {
            if(!slider.pressed) {
                kcImageCanvas.update();
            }
        }
    }
    Text {
        id: percentText
        text: app.brightness + "%"
        anchors.right: root.right
        anchors.verticalCenter: root.verticalCenter
    }
}
