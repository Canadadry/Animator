import QtQuick 2.0
import "Style"

Box {
    width: 100
    height: 62
    id:root
    property variant model
    property variant item: model.get(model.frameSelected)


    Column{
	visible: root.model.frameSelected>=0
	Repeater
	{
	    model:     ListModel{
		id:localModel
		ListElement{shortName:"X";fullName:"m_frameX"}
		ListElement{shortName:"Y";fullName:"m_frameY"}
		ListElement{shortName:"W";fullName:"m_frameWidth"}
		ListElement{shortName:"H";fullName:"m_frameHeight"}
	    }

	    FormLine{
		id:line
		name: shortName
		onValidate: { root.model.setProperty(root.model.frameSelected,fullName,value);}

		Connections{
		    ignoreUnknownSignals: true
		    target: root.model
		    onFrameSelectedChanged:{

			//console.log("getting value")
			line.value = eval("root.item."+fullName);
		    }
		}

	    }
	}
    }

}
