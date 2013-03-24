import QtQuick 2.0

Rectangle {
    id:root
    width: 300
    height: 62
    border.width: 1
    property string  name: "name"
    property alias  value: valueInput.text
    property int textSize : 15

    signal validate()

    Row{
	anchors.fill: parent
	anchors.margins: 10
	Text { text: root.name +" : "; font.pixelSize: root.textSize}
	TextInput {
	    id:valueInput
	    width: 100
	    height: 30
	    focus: true
	    font.pixelSize: root.textSize
	    validator: IntValidator { bottom:0; top: 2000}
	    onAccepted: root.validate()
	}
    }

}
