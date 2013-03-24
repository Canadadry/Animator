import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
    border.width: 10
    default property alias content: container.children
    BorderImage {
	id: border_image1
	verticalTileMode: BorderImage.Repeat
	horizontalTileMode: BorderImage.Repeat
	anchors.margins: 10
	anchors.fill: parent
	source: "bg.png"
    }

    Item {
	id: container
	anchors.fill: parent
	clip:true
	anchors.margins: 10
    }

}
