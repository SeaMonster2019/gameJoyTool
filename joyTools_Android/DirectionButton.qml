import QtQuick 2.15

Image{
    visible : true
    source: "Ui/Resources/DirectionButton.png"
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        hoverEnabled: true

        /*
        onClicked: {
            console.log("Clicked X=",mouse.x,", y=",mouse.y)
        }
        */
   }
}
