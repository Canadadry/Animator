import QtQuick 2.0
import "Style"

Box{
    id:root
    property variant model
    property bool showRect: root.model.frameSelected>=0


    property real  zoom: 1.0
    Flickable {
	anchors.fill: parent
	property variant frame:undefined
	contentWidth:container.width
	contentHeight: container.height
	//	interactive: false
	Item{
	    id:container
	    width: img.sourceSize.width*root.zoom
	    height:  img.sourceSize.height*root.zoom
	    scale: root.zoom
	    transformOrigin: Item.TopLeft
	    Image {
		id: img
		source:root.model.source
		MouseArea{
		    anchors.fill: parent
		    onDoubleClicked: root.model.addFrame(mouseX,mouseY);
		}
		Rectangle{
		    id:area
		    property variant item: model.get(model.frameSelected)

		    visible: root.showRect
		    color: ma.pressed?"#44FF0000":"#22FF0000"
		    border.width: 2
		    border.color: "red"
		    x:visible ? item.m_frameX : 0
		    y:visible ? item.m_frameY : 0
		    width: visible ? item.m_frameWidth : 0
		    height:visible ? item.m_frameHeight : 0

		    MouseArea{
			id:ma
			anchors.fill: parent
			drag.target: parent
			preventStealing: true
			property bool draggin: drag.active
			onPressed: ma.focus = true
			Keys.onLeftPressed: root.model.setProperty(root.model.frameSelected,"m_frameX",area.x-1)
			Keys.onRightPressed: root.model.setProperty(root.model.frameSelected,"m_frameX",area.x+1)
			Keys.onUpPressed: root.model.setProperty(root.model.frameSelected,"m_frameY",area.y-1)
			Keys.onDownPressed: root.model.setProperty(root.model.frameSelected,"m_frameY",area.y+1)
			onDragginChanged: {
			    if(!draggin)
			    {
				root.model.setProperty(root.model.frameSelected,"m_frameX",area.x)
				root.model.setProperty(root.model.frameSelected,"m_frameY",area.y)
			    }
			}
		    }

		    Item{
			id:sizeHandle
			x: root.showRect ? area.item.m_frameWidth : 0
			y: root.showRect ? area.item.m_frameHeight : 0
			onXChanged:  root.showRect ? root.model.setProperty(root.model.frameSelected,"m_frameWidth" ,x) : ""
			onYChanged:  root.showRect ? root.model.setProperty(root.model.frameSelected,"m_frameHeight",y) : ""

			Rectangle{
			    width: 20
			    height: width
			    radius: width/2
			    color: "red"
			    anchors.centerIn: parent
			    MouseArea{
				anchors.fill: parent
				drag.target: sizeHandle
				drag.maximumX:root.model.globalWidth
				drag.maximumY: root.model.globalHeight
				preventStealing: true
			    }
			}
		    }
		}
	    }
	}
    }
}
