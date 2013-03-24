import QtQuick 2.0
import "Style"

Box {
    width: row.width
    height: row.height
    id:root
    property variant model
    signal saved();

    Row{
	id:row

	Rectangle{
	    width: 62
	    height: 62
	    color: ma.pressed?"yellow":"red"
	    MouseArea{id:ma;anchors.fill: parent; onClicked: root.saved()}
	}

	FormLine{
	    name: "duration"
	    onValidate: root.model.frameDuration = value
	    value:root.model.frameDuration
	}

	FormLine{
	    name: "W"
	    onValidate: root.model.globalWidth = value
	    value:root.model.globalWidth
	}

	FormLine{
	    name: "H"
	    onValidate: root.model.globalHeight = value
	    value:root.model.globalHeight
	}

	FormLine{
	    name: "name"
	    onValidate: root.model.name = value
	    value:root.model.name
	}


	FormLine{
	    name: "source"
	    onValidate: root.model.source = value
	    value:root.model.source
	}

    }
}
