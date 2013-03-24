import QtQuick 2.0
import IO 1.0

ListModel{
    id:root
    property int  frameDuration: 100
    property int  frameSelected: -1
    property int  globalWidth : 48
    property int  globalHeight: 48
    property string name: "running"
    property string source: ""//"data/CharactersSD.png"
    //    property string source: "data/explosion.png"

    function removeFrame(index)
    {
	if(index === root.frameSelected)
	{
	    root.frameSelected = -1;
	}
	root.remove(index);
    }

    function addFrame(centerX,centerY)
    {
	if(centerX === undefined || centerY === undefined)
	{
	    centerX = -globalWidth/2;
	    centerY = -globalHeight/2
	}

	root.insertFrame( centerX-globalWidth/2,
			 centerY-globalHeight/2,
			 globalWidth,
			 globalHeight);
    }

    function insertFrame(x,y,w,h)
    {
	root.insert(root.frameSelected+1,{
			"m_frameX"	: parseInt(x),
			"m_frameY"	: parseInt(y),
			"m_frameWidth"  : parseInt(w),
			"m_frameHeight" : parseInt(h)});
	root.frameSelected++;
    }

    function printModel()
    {
	var text = root.source + " ; " + root.name + " ; " +root.frameDuration + " ; " +root.globalWidth + " ; " +root.globalHeight + '\n';

	for(var i = 0;i<root.count;i++)
	{
	    var item = get(i)
	    text+=item.m_frameX+ " ; "+item.m_frameY+" ; "+item.m_frameWidth+" ; "+item.m_frameHeight+"\n"
	}

	console.log(text);
	return text;
    }

    function loadData(dataText,folder)
    {
	String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g, '');};

	var arrayLine = dataText.split("\n");
	var i=0;

	for (; i<arrayLine.length; i++)
	{
	    if(arrayLine[i].trim().length>0) // line not empty
	    {
		console.log("line1 " + i + " = " + arrayLine[i] );
		var data = arrayLine[i].split(';');
		if(data.length === 5)
		{
		    console.log("trying to load : "+"file://"+folder+"/"+data[0])
		    root.source        = "file://"+folder+"/"+data[0];
		    root.name          = data[1];
		    root.frameDuration = data[2];
		    root.globalWidth   = data[3];
		    root.globalHeight  = data[4];
		    break;
		}
	    }
	}

	for (; i<arrayLine.length; i++)
	{
	    if(arrayLine[i].trim().length>0) // line not empty
	    {
		console.log("line2 " + i + " = " + arrayLine[i] );
		var data = arrayLine[i].split(';');
		if(data.length === 4)
		{
		    root.insertFrame( data[0],
				     data[1],
				     data[2],
				     data[3]);
		}
	    }
	}
    }

    //    ListElement{m_frameX:0   ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:48  ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:96  ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:144 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:192 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:240 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:288 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:336 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }
    //    ListElement{m_frameX:384 ; m_frameY:0 ; m_frameWidth:48 ; m_frameHeight:48 }

    //   ListElement{ m_frameX : 86  ; m_frameY : 764 ; m_frameWidth : 48 ; m_frameHeight : 48 }
    //   ListElement{ m_frameX : 428 ; m_frameY : 733 ; m_frameWidth : 48 ; m_frameHeight : 48 }
    //   ListElement{ m_frameX : 478 ; m_frameY : 764 ; m_frameWidth : 48 ; m_frameHeight : 48 }
    //   ListElement{ m_frameX : 873 ; m_frameY : 785 ; m_frameWidth : 48 ; m_frameHeight : 48 }

    
}
