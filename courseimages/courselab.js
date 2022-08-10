/* File	name: courselab.js
v.2.7 170305
(c)2002-2017 Websoft Ltd., Russia */

var g_sComponent = "Component";
var g_sIsNotInstalled = " is not installed.";
var g_sLoadingImages = "Loading images";
var g_sSkip = "Skip";
var g_sAudioWarning = "Module contains audio files. Press button below to allow audio.";
var g_sProceed = "Continue";

var g_oEnv =
{
	VML: false,
	SVG:
	{
		inline: false,
		inject: false,
		append: false,
		type: ""
	},
	browser:
	{
		isIE: false,
		isFF: false,
		isChrome: false,
		isOpera: false,
		isSafari: false,
		isWebkit: false,
		version: 0
	}
};
var g_isMSIE = false;
var g_isFirefox = false;
var g_isOpera = false;
var g_isWebkit = false;
var g_isSafari = false;
var g_sCSSPrefix = "";
var g_nFirst = 1;
var g_sMSXMLProgID;
var g_sMSXMLHTTPProgID;

var g_oBoardFrame;

var g_oDoc;
var g_oModule;
var g_oSlides;
var g_oMasters;
var g_oGroups;
var g_oMethods;
var g_oParams;

var g_oMaster;
var g_oMasterFrame;
var g_oSlide;
var g_oSlideFrame;
var g_sSlideFrameId = "";

var g_sReturnFrameId = null;

var g_arVars = [];
var g_arSlideVars = [];

var g_nSlideBeginTime;
var g_nSlideEndTime;
var g_nSlideCurrentTime;
var g_nPauseBeginTime;
var g_nFrameBeginTime;

var g_bPause = false;

var g_bDragOn;
var g_nOffsetX;
var g_nOffsetY;
var g_oDragObject;
var g_oDragTarget;
var g_oDHTMLDragTarget;

/* SCO */
var g_oDocSCO;
var g_oSCO;

var g_bStrictOrder = false;
var g_bPreloadImages = false;
var g_bNormalize = false;

var g_oImages = null;
var g_nImages = 0;
var g_bPreloadingImages = false;

var g_bSoundEnabled = true;
var g_bSoundOn = false;
var g_sSoundId = null;
var g_bWMSoundOn = false;
var g_bSWSoundOn = false;

var g_vPropertyValue = null;
var g_arMethodReturnValue = new Array();

var g_listDisplayObjects = new List;
var g_listThreads = new List;
var g_nCurrentTime = 0;
var g_nTimeoutId = 0;

var g_listEvtHandlers = new List;

var g_nFrameNum = 0;

/* 2.7 */
var g_iTimeLineTick = 20;
var g_iTimeLineId = null;
var g_aTimeLine = [];
var g_aReturnValues = [];
var g_bSVGInline = false;
var g_sUA = navigator.userAgent;
var g_sUserAgent = g_sUA.toLowerCase();
var g_aUAParts;
var g_aObjectRes = {};
var g_nVersion = 0;
var g_aParams = [];
/* 2.7.5 */
var g_oTooltip = null;
/* 20121122 */
var g_bLooseX = false;
var g_bLooseY = false;
var g_bSnapX = false;
var g_bSnapY = false;
/* 130902 */
var g_bDebugInfo = false;
var g_iMaskZIndex = 10000;
var g_oAudioPlayer = null;
var g_oAudioPlayerInt = null;

var g_isMSIE11 = (!!navigator.userAgent.match(/Trident\/7\./));

if(g_sUserAgent.indexOf("msie")!=-1)
{ 
	g_nVersion = -1;
	if(navigator.appName == "Microsoft Internet Explorer")
	{
		var reUA  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if(reUA.exec(g_sUA) != null)
		{
			g_nVersion = parseInt( RegExp.$1 );
		}
	}
}
else if(g_sUserAgent.indexOf("firefox/")!=-1)
{
	g_aUAParts = g_sUserAgent.split("firefox/");
	g_nVersion = parseInt(g_aUAParts[1], 10);
	g_bSVGInline = (g_nVersion>=4);
}
else if(g_sUserAgent.indexOf("chrome/")!=-1)
{
	g_aUAParts = g_sUserAgent.split("chrome/");
	g_nVersion = parseInt(g_aUAParts[1], 10);
	g_bSVGInline = (g_nVersion>=7);
}
else if(g_sUserAgent.indexOf("opera/")!=-1)
{
	g_aUAParts = g_sUserAgent.split("version/");
	g_nVersion = parseFloat(g_aUAParts[1]);
	g_bSVGInline = (g_nVersion>=12);
}
else if(g_sUserAgent.indexOf("safari/")!=-1)
{
	g_aUAParts = g_sUserAgent.split("version/");
	g_nVersion = parseFloat(g_aUAParts[1]);
	g_bSVGInline = (g_nVersion>=5.1);
}


if (!Array.prototype.indexOf)
{
	Array.prototype.indexOf = function(elt /*, from*/)
	{
		var len = this.length;
  
		var from = Number(arguments[1]) || 0;
		from = (from < 0) ? Math.ceil(from) : Math.floor(from);
		if (from < 0) from += len;
		for (; from < len; from++)
		{
			if (from in this &&	this[from] === elt)  return from;
		}
		return -1;
	};
}

/* END 2.7 */

/* 2.7.5 */
g_oEnv.iOS = g_sUserAgent.match(/(iphone|ipod|ipad)/);
g_oEnv.Android = g_sUserAgent.match(/(android)/);
g_oEnv.touch = g_oEnv.iOS || g_oEnv.Android;

var clTouch =
{
	Begin: function (oElement, oEvent)
	{
		oEvent.preventDefault();
		g_bDragOn = true;
		g_oDragObject = oElement;
		clTouch.LastId = oElement.getAttribute("id");
		g_nOffsetX = oEvent.touches[0].pageX - parseInt(oElement.style.left);
		g_nOffsetY = oEvent.touches[0].pageY - parseInt(oElement.style.top);
		clTouch.Tooltip(oElement, oEvent);
		return true;
	},
	Cancel: function (oElement, oEvent)
	{
		g_bDragOn = false;
		g_oDragObject = null;
		g_oDragTarget = null;
		g_oDHTMLDragTarget = null;
		clTouch.LastId = "";
		return false;
	},
	End: function (oElement, oEvent)
	{
		oEvent.preventDefault();
		if(g_bDragOn)
		{
			var bLooseX = g_bLooseX;
			var bLooseY = g_bLooseX;
			var bLoose = bLooseX || bLooseY;
			var bSnapX = g_bSnapX;
			var bSnapY = g_bSnapY;
			if(oElement.getAttribute("id")!=clTouch.LastId) return false;
			g_bDragOn = false;
			g_oDragObject = oElement;
			var sDragObjectId = oElement.id;
			
			GetDropTarget(clTouch.eventX, clTouch.eventY, sDragObjectId);  /* by mouse XY */
			if(bLoose && (g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null)))
			{
				var nX1 = g_oDragObject.offsetLeft + g_oDragObject.offsetWidth;
				var nY1 = g_oDragObject.offsetTop + g_oDragObject.offsetHeight;
				if(bLooseX && bLooseY)
				{
					GetDropTarget(g_oDragObject.offsetLeft, g_oDragObject.offsetTop, sDragObjectId); /* by left-top */
					if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
					{
						GetDropTarget(nX1, nY1, sDragObjectId); /* by right-bottom */
						if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
						{
							GetDropTarget(g_oDragObject.offsetLeft, nY1, sDragObjectId); /* by left-bottom */
							if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
							{
								GetDropTarget(nX1, g_oDragObject.offsetTop, sDragObjectId); /* by right-top - last attempt */
							}
						}
					}
				}
				else if(bLooseX && !bLooseY)
				{
					GetDropTarget(g_oDragObject.offsetLeft, clTouch.eventY, sDragObjectId); /* by left-mouseY */
					if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
					{
						GetDropTarget(nX1, clTouch.eventY, sDragObjectId); /* by right-mouseY */
					}
				}
				else if(!bLooseX && bLooseY)
				{
					GetDropTarget(clTouch.eventX, g_oDragObject.offsetTop, sDragObjectId); /* by mouseX-top */
					if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
					{
						GetDropTarget(clTouch.eventX, nY1, sDragObjectId); /* by mouseX-bottom */
					}
				}
			}
			var sDragObjectId = g_oDragObject.getAttribute("id");
			var oDisplayObject = FindDisplayObject(sDragObjectId);
			if(oDisplayObject)
			{
				oDisplayObject.nX = g_oDragObject.offsetLeft - oDisplayObject.nRX;
				oDisplayObject.nY = g_oDragObject.offsetTop - oDisplayObject.nRY;
			}
		
			HandleEvt("EVENT_DRAG_END", null);
		
			if(g_oDragTarget != null)
			{
				var sTargetId = g_oDragTarget.getAttribute("id");
				var oTarget = g_oSlides.selectSingleNode("slide/frames/frame/object[@id='" + sTargetId + "']");
				if(oTarget)
				{
					var sResponseId = oTarget.getAttribute("ondrop");
					if (sResponseId != null)
					{
						if (window.Event)
						{
							window.releaseEvents(Event.TOUCHMOVE);
						}
						if(bSnapX)
						{
							var nX = parseInt(g_oDragTarget.style.left) + Math.round(0.5*(g_oDragTarget.offsetWidth - g_oDragObject.offsetWidth));
							g_oDragObject.style.left = nX + "px";
						}
						if(bSnapY)
						{
							var nY = parseInt(g_oDragTarget.style.top) + Math.round(0.5*(g_oDragTarget.offsetHeight - g_oDragObject.offsetHeight));
							g_oDragObject.style.top = nY + "px";
						}
						processEvent(sResponseId);
					}
				}
			}
			
			if(g_oTooltip!=null) g_oTooltip.style.display = "none";
			g_oDragObject = null;
			g_oDragTarget = null;
			g_oDHTMLDragTarget = null;
			clTouch.LastId = "";
		}
		return true;
	},
	Move: function (oElement, oEvent)
	{
		if (g_bDragOn)
		{
			oEvent.preventDefault();
			var iX = oEvent.touches[0].pageX - g_nOffsetX;
			var iY = oEvent.touches[0].pageY - g_nOffsetY;
			oElement.style.left = iX + "px";
			oElement.style.top = iY + "px";
			oElement.setAttribute("touchx", oEvent.touches[0].pageX);
			oElement.setAttribute("touchy", oEvent.touches[0].pageY);
			clTouch.eventX = oEvent.touches[0].pageX;
			clTouch.eventY = oEvent.touches[0].pageY;
		}
		return true;
	},
	LastId: "",
	Tooltip: function (oElement, oEvent)
	{
		var sTitle = oElement.getAttribute("title");
		if(sTitle==null || sTitle=="")
		{
			sTitle = oElement.getAttribute("alt");
			if(sTitle==null || sTitle=="") return false;
		}
		if(oEvent.touches[0]!=null)
		{
			g_oTooltip = document.getElementById("cl_tooltip");
			if(g_oTooltip==null)
			{
				g_oTooltip = document.createElement("div");
				g_oTooltip.className = "CL-tooltip";
				g_oBoardFrame.appendChild(g_oTooltip);
			}
			g_oTooltip.innerHTML = sTitle;
			g_oTooltip.style.left = (oEvent.touches[0].pageX - 48) + "px";
			g_oTooltip.style.top = (oEvent.touches[0].pageY - 48) + "px";
			g_oTooltip.style.display = "block";
		}
		return true;
	},
	eventX: 0,
	eventY: 0
}

/* 2.7.5 */
/* 2.7.5.1 */
var clDrag =
{
	Begin: function (oEvent)
	{
		if(g_bDragOn) return true;
		if (oEvent == null) oEvent = window.event;    
		var oDragged = (oEvent.target!=null) ? oEvent.target : oEvent.srcElement;
		if(oDragged.getAttribute("onclick")!=null)
		{
			return false;
		}
		var bDraggable = (oDragged.getAttribute("-cl-draggable")=="1");
		while(!bDraggable)
		{
			oDragged = oDragged.parentNode;
			if(oDragged.getAttribute("onclick")!=null)
			{
				return false;
			}
			if(oDragged.getAttribute("id")=="boardFrame") return true;
			bDraggable = (oDragged.getAttribute("-cl-draggable")=="1");
		}
		if (((oEvent.button==1 && window.event!=null) || oEvent.button == 0) && oDragged.getAttribute("-cl-draggable")=="1")
		{
			g_bDragOn = true; 
			if (oDragged.setCapture)
			{
				oDragged.setCapture(true);
			}
			else
			{
				oEvent.preventDefault();
				if (window.Event)
				{
					window.captureEvents(Event.MOUSEMOVE);
					window.captureEvents(Event.MOUSEOVER);
					window.captureEvents(Event.MOUSEOUT);
				}
			}
			clDrag.startX = oEvent.clientX;
			clDrag.startY = oEvent.clientY;
			clDrag.offsetX = parseInt(oDragged.style.left, 10);
			clDrag.offsetY = parseInt(oDragged.style.top, 10);
			g_nOffsetX = clDrag.startX - clDrag.offsetX;
			g_nOffsetY = clDrag.startY - clDrag.offsetX;
			clDrag.oldZ = oDragged.style.zIndex;
			oDragged.style.zIndex = 10000;
			clDrag.dragged = oDragged;
			clDrag.moved = false;
			g_oDragObject = oDragged;
			document.onmousemove = clDrag.Move;
			document.onmouseup = clDrag.End;
			document.body.focus();
			document.onselectstart = function () { return false; };
			oDragged.ondragstart = function() { return false; };
			return false;
		}
		return true;
	},
	End: function (oEvent)
	{
		if (clDrag.dragged!=null)
		{
			var bLooseX = g_bLooseX;
			var bLooseY = g_bLooseY;
			var bLoose = bLooseX || bLooseY;
			var bSnapX = g_bSnapX;
			var bSnapY = g_bSnapY;
			g_bDragOn = false;
			g_oDragObject = clDrag.dragged;
			var sDragObjectId = clDrag.dragged.getAttribute("id");
			if(clDrag.eventX!=null && clDrag.eventY!=null)
			{
				GetDropTarget(clDrag.eventX, clDrag.eventY, sDragObjectId);  /* by mouse XY */
				if(bLoose && (g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null)))
				{
					var nX1 = clDrag.dragX + clDrag.dragged.offsetWidth;
					var nY1 = clDrag.dragY + clDrag.dragged.offsetHeight;
					if(bLooseX && bLooseY)
					{
						GetDropTarget(clDrag.dragX, clDrag.dragY, sDragObjectId); /* by left-top */
						if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
						{
							GetDropTarget(nX1, nY1, sDragObjectId); /* by right-bottom */
							if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
							{
								GetDropTarget(clDrag.dragX, nY1, sDragObjectId); /* by left-bottom */
								if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
								{
									GetDropTarget(nX1, clDrag.dragY, sDragObjectId); /* by right-top - last attempt */
								}
							}
						}
					}
					else if(bLooseX && !bLooseY)
					{
						GetDropTarget(clDrag.dragX, clDrag.eventY, sDragObjectId); /* by left-mouseY */
						if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
						{
							GetDropTarget(nX1, clDrag.eventY, sDragObjectId); /* by right-mouseY */
						}
					}
					else if(!bLooseX && bLooseY)
					{
						GetDropTarget(clDrag.eventX, clDrag.dragY, sDragObjectId); /* by mouseX-top */
						if(g_oDragTarget == null || (g_oDragTarget!=null && clDrag.HasOndrop(g_oDragTarget)==null))
						{
							GetDropTarget(clDrag.eventX, nY1, sDragObjectId); /* by mouseX-bottom */
						}
					}
				}
				var oDisplayObject = FindDisplayObject(sDragObjectId);
				if(oDisplayObject)
				{
					oDisplayObject.nX = clDrag.dragged.offsetLeft - oDisplayObject.nRX;
					oDisplayObject.nY = clDrag.dragged.offsetTop - oDisplayObject.nRY;
				}
				if (g_oDragObject.releaseCapture)
				{
					g_oDragObject.releaseCapture();
				}
				else
				{
					if (window.Event)
					{
						window.releaseEvents(Event.MOUSEMOVE);
						window.releaseEvents(Event.MOUSEOVER);
						window.releaseEvents(Event.MOUSEOUT);
					}
				}
				HandleEvt("EVENT_DRAG_END", null);
				var sResponseId = clDrag.HasOndrop(g_oDragTarget);
				if (sResponseId != null)
				{
					if(bSnapX)
					{
						var nX = parseInt(g_oDragTarget.style.left) + Math.round(0.5*(g_oDragTarget.offsetWidth - clDrag.dragged.offsetWidth));
						clDrag.dragged.style.left = nX + "px";
					}
					if(bSnapY)
					{
						var nY = parseInt(g_oDragTarget.style.top) + Math.round(0.5*(g_oDragTarget.offsetHeight - clDrag.dragged.offsetHeight));
						clDrag.dragged.style.top = nY + "px";
					}
					processEvent(sResponseId);
				}
			}
			clDrag.dragged.style.zIndex = clDrag.oldZ;
			document.onmousemove = null;
			document.onmouseup = null;
			document.onselectstart = null;
			clDrag.dragged.ondragstart = null; 
			clDrag.dragged = null;
			clDrag.eventX = null;
			clDrag.eventY = null;
			g_oDragTarget = null;
			g_oDHTMLDragTarget = null;
			g_oDragObject = null;
		}	
	},
	HasOndrop: function (oObject)
	{
		if(oObject != null)
		{
			var sTargetId = oObject.getAttribute("id");
			var oTarget = g_oSlides.selectSingleNode("slide/frames/frame/object[@id='" + sTargetId + "']");
			if(oTarget != null)
			{
				return oTarget.getAttribute("ondrop");
			}
		}
		return null;
	},
	Move: function (oEvent)
	{
		if (oEvent == null) oEvent = window.event;
		clDrag.dragX = (clDrag.offsetX + oEvent.clientX - clDrag.startX);
		clDrag.dragY = (clDrag.offsetY + oEvent.clientY - clDrag.startY);
		clDrag.dragged.style.left =  clDrag.dragX + "px";
		clDrag.dragged.style.top = clDrag.dragY + "px";
		clDrag.eventX = oEvent.clientX;
		clDrag.eventY = oEvent.clientY;
		clDrag.moved = true;
		return true;
	},
	dragged: null,
	dragOn: false,
	dragX: 0,
	dragY: 0,
	eventX: 0,
	eventY: 0,
	offsetX: 0,
	offsetY: 0,
	oldZ: 0,
	startX: 0,
	startY: 0
}
/* 2.7.5.1 */
/* LIST */
function List()
{
	this.pFirst = null;
	this.pLast = null;

	this.Add = List_Add;
	this.AddBefore = List_AddBefore;
	this.Subtract = List_Subtract;
	this.Destroy = List_Destroy;
}
function List_Add(pElement)
{
	if (this.pFirst == null)
	{
		pElement.pPrevious = null;
		pElement.pNext = null;

		this.pFirst = pElement;
		this.pLast = pElement;
	}
	else
	{
		pElement.pPrevious = this.pLast;
		pElement.pNext = null;

		this.pLast.pNext = pElement;
		this.pLast = pElement;
	}
}
function List_AddBefore(pElement, pBefore)
{
	if (pBefore == null || this.pFirst == null)
	{
		this.Add(pElement);
		return;
	}

	var pBeforePrevious = pBefore.pPrevious;

	pElement.pPrevious = pBeforePrevious;
	if (pBeforePrevious)
		pBeforePrevious.pNext = pElement;
	else
		this.pFirst = pElement;

	pElement.pNext = pBefore;
	pBefore.pPrevious = pElement;
}
function List_Subtract(pElement)
{
	var bFound = false;
	for (var pTest = this.pFirst; pTest != null; pTest = pTest.pNext)
		if (pTest === pElement)
		{
			bFound = true;
			break;
		}

	if (bFound)
	{
		var pPrevious = pElement.pPrevious;
		if (pPrevious)
			pPrevious.pNext = pElement.pNext;
		else
			this.pFirst = pElement.pNext;

		var pNext = pElement.pNext;
		if (pNext)
			pNext.pPrevious = pElement.pPrevious;
		else
			this.pLast = pElement.pPrevious;

		pElement.pPrevious = null;
		pElement.pNext = null;
	}
}
function List_Destroy()
{
	this.pFirst = null;
	this.pLast = null;
}

/* THREAD */
function Thread()
{
	this.listActions = new List;
	this.oCurrentAction = null;
}
function Thread_Load(oThread, oActions)
{
	var listActions = oThread.listActions;
	var nLength = oActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltAction = oActions[i];
		if (eltAction.nodeType == 1)
		{
			var oAction = new Action;
			listActions.Add(oAction);
			oAction.Load(eltAction);
		}
	}
	oThread.oCurrentAction = listActions.pFirst;
}
function Thread_Continue(oThread)
{
	for (;;)
	{
		var oAction = oThread.oCurrentAction;
		if (oAction == null)
			break;

		oThread.oCurrentAction = oAction.Continue();
		if (oThread.oCurrentAction == oAction)
			break;
	}
	return oThread.oCurrentAction;
}
function InsertWaitAtThreadBegin(oThread, nDur)
{
	var oWait = new Action;
	oWait.sType = "WAIT";
	oWait.sCheck = "0";
	oWait.sDur = nDur;
	oWait.nStartTime = 0;
	oWait.Continue = Action_ContinueWAIT;

	oThread.listActions.AddBefore(oWait, oThread.listActions.pFirst);
	oThread.oCurrentAction = oWait;
}

/* ACTION */
function Action()
{
	this.Load = Action_Load;
	this.GetNearTime = Action_GetNearTime;
}
function Action_Load(eltAction)
{
	var sTagName = eltAction.tagName;
	this.sType = sTagName;
	switch (sTagName)
	{
		case "ALPHA":
		{
			Action_LoadALPHA(this, eltAction);
			this.Continue = Action_ContinueALPHA;
			break;
		}
		case "CANCELMOVE":
		{
			Action_LoadCANCELMOVE(this, eltAction);
			this.Continue = Action_ContinueCANCELMOVE;
			break;
		}
		case "CANCELROTATE":
		{
			Action_LoadCANCELROTATE(this, eltAction);
			this.Continue = Action_ContinueCANCELROTATE;
			break;
		}
		case "CANCELSIZE":
		{
			Action_LoadCANCELSIZE(this, eltAction);
			this.Continue = Action_ContinueCANCELSIZE;
			break;
		}
		case "CHECKHIT":
		{
			Action_LoadCHECKHIT(this, eltAction);
			this.Continue = Action_ContinueCHECKHIT;
			break;
		}
		case "DESTROY":
		{
			Action_LoadDESTROY(this, eltAction);
			this.Continue = Action_ContinueDESTROY;
			break;
		}
		case "DISPLAY":
		{
			Action_LoadDISPLAY(this, eltAction);
			this.Continue = Action_ContinueDISPLAY;
			break;
		}
		case "GOTO":
		{
			Action_LoadGOTO(this, eltAction);
			this.Continue = Action_ContinueGOTO;
			break;
		}
		case "GOSUB":
		{
			Action_LoadGOSUB(this, eltAction);
			this.Continue = Action_ContinueGOSUB;
			break;
		}
		case "FOR":
		{
			Action_LoadFOR(this, eltAction);
			this.Continue = Action_ContinueFOR;
			break;
		}
		case "IF":
		{
			Action_LoadIF(this, eltAction);
			this.Continue = Action_ContinueIF;
			break;
		}
		case "IF_COMPLETION_STATUS":
		{
			Action_LoadIFCOMPLETIONSTATUS(this, eltAction);
			this.Continue = Action_ContinueIFCOMPLETIONSTATUS;
			break;
		}
		case "IF_SCORE":
		{
			Action_LoadIFSCORE(this, eltAction);
			this.Continue = Action_ContinueIFSCORE;
			break;
		}
		case "IF_SUCCESS_STATUS":
		{
			Action_LoadIFSUCCESSSTATUS(this, eltAction);
			this.Continue = Action_ContinueIFSUCCESSSTATUS;
			break;
		}
		case "JAVASCRIPT":
		{
			Action_LoadJAVASCRIPT(this, eltAction);
			this.Continue = Action_ContinueJAVASCRIPT;
			break;
		}
		case "JUMP":
		{
			Action_LoadJUMP(this, eltAction);
			this.Continue = Action_ContinueJUMP;
			break;
		}
		case "MEDIAPLAY":
		{
			Action_LoadMEDIAPLAY(this, eltAction);
			this.Continue = Action_ContinueMEDIAPLAY;
			break;
		}
		case "METHOD":
		{
			Action_LoadMETHOD(this, eltAction);
			this.Continue = Action_ContinueMETHOD;
			break;
		}
		case "MOVE":
		{
			Action_LoadMOVE(this, eltAction);
			this.Continue = Action_ContinueMOVE;
			break;
		}
		case "MSGBOX":
		{
			Action_LoadMSGBOX(this, eltAction);
			this.Continue = Action_ContinueMSGBOX;
			break;
		}
		case "NAVIGATION":
		{
			Action_LoadNAVIGATION(this, eltAction);
			this.Continue = Action_ContinueNAVIGATION;
			break;
		}
		case "PAR":
		{
			Action_LoadPAR(this, eltAction);
			this.Continue = Action_ContinuePAR;
			break;
		}
		case "PRINT":
		{
			Action_LoadPRINT(this, eltAction);
			this.Continue = Action_ContinuePRINT;
			break;
		}
		case "RETURN":
		{
			Action_LoadRETURN(this, eltAction);
			this.Continue = Action_ContinueRETURN;
			break;
		}
		case "ROTATE":
		{
			Action_LoadROTATE(this, eltAction);
			this.Continue = Action_ContinueROTATE;
			break;
		}
		case "SET_SCORE":
		{
			Action_LoadSETSCORE(this, eltAction);
			this.Continue = Action_ContinueSETSCORE;
			break;
		}
		case "SET_COMPLETION_STATUS":
		{
			Action_LoadSETCOMPLETIONSTATUS(this, eltAction);
			this.Continue = Action_ContinueSETCOMPLETIONSTATUS;
			break;
		}
		case "SET_SUCCESS_STATUS":
		{
			Action_LoadSETSUCCESSSTATUS(this, eltAction);
			this.Continue = Action_ContinueSETSUCCESSSTATUS;
			break;
		}
		case "SEQ":
		case "BEGIN_ASYNC":
		{
			Action_LoadSEQ(this, eltAction);
			this.Continue = Action_ContinueSEQ;
			break;
		}
		case "SIZE":
		{
			Action_LoadSIZE(this, eltAction);
			this.Continue = Action_ContinueSIZE;
			break;
		}
		case "TIMER":
		{
			Action_LoadTIMER(this, eltAction);
			this.Continue = Action_ContinueTIMER;
			break;
		}
		case "VARIABLE":
		{
			Action_LoadVARIABLE(this, eltAction);
			this.Continue = Action_ContinueVARIABLE;
			break;
		}
		case "WAIT":
		{
			Action_LoadWAIT(this, eltAction);
			this.Continue = Action_ContinueWAIT;
			break;
		}
		case "ZINDEX":
		{
			Action_LoadZINDEX(this, eltAction);
			this.Continue = Action_ContinueZINDEX;
			break;
		}
		default:
		{
			alert("?Action:	" +	sTagName);
			brek;
		}
	}
}
function Action_GetNearTime()
{
	var nNearTime = g_nCurrentTime + 60000;

	switch (this.sType)
	{
		case "WAIT":
			if (this.nStartTime == 0)
				nNearTime = g_nCurrentTime;
			else
				nNearTime = this.nEndTime;
			break;

		case "MOVE":
		case "ROTATE":
			if (this.nStartTime == 0)
				nNearTime = g_nCurrentTime;
			else
				nNearTime = this.nStartTime > g_nCurrentTime ? this.nStartTime : g_nCurrentTime + 10;
			break;
	}
	return nNearTime;
}
function Action_LoadALPHA(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sStart = eltAction.getAttribute("start");
	oAction.sEnd = eltAction.getAttribute("end");
	oAction.sDur = eltAction.getAttribute("dur");
	oAction.nStartTime = 0;
}
function Action_ContinueALPHA()
{
	var oDisplayObject = FindDisplayObject(this.sTargetId);

	if (this.nStartTime == 0)
	{
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		this.bCancelled = false;

		if (oDisplayObject)
		{
			oDisplayObject.oActionAlpha = this;

			this.nStart = parseInt(EvalExpr(this.sStart, true));
			this.nEnd = parseInt(EvalExpr(this.sEnd, true));
			this.nDistance = this.nEnd - this.nStart;
		}
	}

	var oTarget = document.getElementById(this.sTargetId);
	var oStyle = oTarget ? oTarget.style : null;

	if (this.bCancelled)
	{
		this.nStartTime = 0;
		return this.pNext;
	}

	if (g_nCurrentTime >= this.nEndTime)
	{
		if (oDisplayObject)
		{
			oDisplayObject.nA = this.nEnd;
			oDisplayObject.oActionAlpha = null;
		}
		if (oTarget)
		{
			oStyle.opacity = parseFloat(this.nEnd)/100;
		}

		this.nStartTime = 0;
		return this.pNext;
	}

	var nScale = (g_nCurrentTime - this.nStartTime) / this.nDur;
	var nA = parseInt(this.nStart + this.nDistance * nScale);

	if (oDisplayObject)
	{
		oDisplayObject.nA = nA;
	}
	if (oTarget)
	{
		oStyle.opacity = parseFloat(nA)/100;
	}
	return this;
}
function Action_LoadCANCELMOVE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAll = eltAction.getAttribute("all");
}
function Action_ContinueCANCELMOVE()
{
	if (this.sAll == "1")
		CancelMoveAllDisplayObjects();
	else
		CancelMoveDisplayObject(this.sTargetId);

	return this.pNext;
}
function Action_LoadCANCELROTATE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAll = eltAction.getAttribute("all");
}
function Action_ContinueCANCELROTATE()
{
	if (this.sAll == "1")
		CancelRotateAllDisplayObjects();
	else
		CancelRotateDisplayObject(this.sTargetId);

	return this.pNext;
}
function Action_LoadCANCELSIZE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAll = eltAction.getAttribute("all");
}
function Action_ContinueCANCELSIZE()
{
	if (this.sAll == "1")
		CancelSizeAllDisplayObjects();
	else
		CancelSizeDisplayObject(this.sTargetId);

	return this.pNext;
}
function Action_LoadCHECKHIT(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");

	oAction.listActions = new List;
	oAction.listElseActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "ELSE" && eltChild.tagName != "if")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	var eltElse = eltAction.selectSingleNode("ELSE");
	if (eltElse != null)
	{
		listActions = oAction.listElseActions;
		nodesActions = eltElse.childNodes;
		nLength = nodesActions.length;
		for (i = 0; i < nLength; i++)
		{
			var eltChild = nodesActions[i];
			if (eltChild.nodeType == 1)
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueCHECKHIT()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		var sDragObjectId = (g_oDragObject!=null) ? g_oDragObject.getAttribute("id") : "-";
		var bConditionOk = ((this.sTargetId == sDragObjectId) ? true : false);

		this.oCurrentAction = bConditionOk ? this.listActions.pFirst : this.listElseActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadDESTROY(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
}
function Action_ContinueDESTROY()
{
	var sTargetId = this.sTargetId;

	var oTarget = document.getElementById(sTargetId);
	if (oTarget != null)
		oTarget.parentNode.removeChild(oTarget);

	/* Remove display object */
	var oDisplayObject = FindDisplayObject(sTargetId);
	if (oDisplayObject != null)
		g_listDisplayObjects.Subtract(oDisplayObject);

	/* Remove event handlers */
	for (var oEvtHandler = g_listEvtHandlers.pFirst; oEvtHandler != null; )
	{
		var pNext = oEvtHandler.pNext;
		if (oEvtHandler.sTargetId == sTargetId)
			g_listEvtHandlers.Subtract(oEvtHandler);
		oEvtHandler = pNext;
	}

	return this.pNext;
}
function Action_LoadDISPLAY(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sDisplay = eltAction.getAttribute("display");
	oAction.sTransition = eltAction.getAttribute("transition");
	oAction.sDur = eltAction.getAttribute("dur");

	oAction.nStartTime = 0;
}
function Action_ContinueDISPLAY()
{
	if (this.nStartTime == 0)
	{
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		if (this.sDisplay != "none")
			ShowObject(this.sTargetId, parseInt(this.sTransition), this.nDur);
		else
			HideObject(this.sTargetId, parseInt(this.sTransition), this.nDur);
	}

	if (g_nCurrentTime >= this.nEndTime)
	{
		HandleEvt("EVENT_DISPLAY_STATE_CHANGED", null);

		this.nStartTime = 0;
		return this.pNext;
	}

	return this;
}
function Action_LoadGOTO(oAction, eltAction)
{
	oAction.sOption = eltAction.getAttribute("option");
	oAction.sFrameId = eltAction.getAttribute("pid");
	oAction.fromAction = true;
	oAction.nStartTime = 0;
}
function Action_ContinueGOTO()
{ 
	switch (this.sOption)
	{
		case "0":
		{
			var oNewFrame = g_oSlides.selectSingleNode("slide/frames/frame[@id=\""+this.sFrameId+"\"]");
			if (oNewFrame != null)
			{
				var oNewSlide = oNewFrame.parentNode.parentNode;
				if (oNewSlide.getAttribute("id") == g_oSlide.getAttribute("id"))
					OpenFrame(oNewFrame, false);
				else
					OpenSlide(oNewSlide, this.sFrameId);
			}
			break;
		}
		case "1":
			NextFrame(this.fromAction);
			break;
		case "2":
			PreviousFrame(this.fromAction);
			break;
		case "3":
			NextSlide(this.fromAction);
			break;
		case "4":
			PreviousSlide(this.fromAction);
			break;
	}
}
function Action_LoadGOSUB(oAction, eltAction)
{
	oAction.sOption = eltAction.getAttribute("option");
	oAction.sFrameId = eltAction.getAttribute("pid");
}
function Action_ContinueGOSUB()
{
	g_sReturnFrameId = g_oSlideFrame.getAttribute("id");

	if (this.sOption != null)
	{
		/* new */
		switch (this.sOption)
		{
			case "0":
			{
				var oNewFrame = g_oSlides.selectSingleNode("slide/frames/frame[@id=\""+this.sFrameId+"\"]");
				if (oNewFrame != null)
				{
					var oNewSlide = oNewFrame.parentNode.parentNode;
					if (oNewSlide.getAttribute("id") == g_oSlide.getAttribute("id"))
						OpenFrame(oNewFrame, false);
					else
						OpenSlide(oNewSlide, this.sFrameId);
				}
				break;
			}
			case "1":
				NextFrame();
				break;
			case "2":
				PreviousFrame();
				break;
			case "3":
				NextSlide();
				break;
			case "4":
				PreviousSlide();
				break;
		}
	}
	else
	{
		/* old */
		var oNewSlide = g_oSlides.selectSingleNode("slide[@id=\""+this.sFrameId+"\"]");
		if (oNewSlide != null)
			OpenSlide(oNewSlide, null);
		else
		{
			var oNewFrame = g_oSlides.selectSingleNode("slide/frames/frame[@id=\""+this.sFrameId+"\"]");
			if (oNewFrame != null)
				OpenFrame(oNewFrame, false);
		}
	}

	return this.pNext;
}
function Action_LoadFOR(oAction, eltAction)
{
	oAction.sName = eltAction.getAttribute("name");

	oAction.eltFrom = eltAction.selectSingleNode("from");
	oAction.eltTo = eltAction.selectSingleNode("to");
	oAction.eltStep = eltAction.selectSingleNode("step");

	oAction.listActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "from" && eltChild.tagName != "to" && eltChild.tagName != "step")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueFOR()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		this.nFrom = parseFloat(GetExpr(this.eltFrom));
		this.nTo = parseFloat(GetExpr(this.eltTo));
		this.nStep = parseFloat(GetExpr(this.eltStep));

		this.nVar = this.nFrom;

		this.oCurrentAction = this.listActions.pFirst;
	}

	if (this.sGlobal == "1")
		g_arVars[this.sName] = this.nVar;
	else
		g_arSlideVars[this.sName] = this.nVar;

	if (this.nVar <= this.nTo)
	{
		for (;;)
		{
			var oAction = this.oCurrentAction;
			if (oAction == null)
				break;

			this.oCurrentAction = oAction.Continue();
			if (this.oCurrentAction == oAction)
				break;
		}
		if (this.oCurrentAction)
			return this;

		/* Reset */
		this.nVar += this.nStep;
		if (this.nVar <= this.nTo)
		{
			this.oCurrentAction = this.listActions.pFirst;
			return this;
		}
	}

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadIF(oAction, eltAction)
{
	oAction.eltIf = eltAction.selectSingleNode("if");

	oAction.listActions = new List;
	oAction.listElseActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "ELSE" && eltChild.tagName != "if")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	var eltElse = eltAction.selectSingleNode("ELSE");
	if (eltElse != null)
	{
		listActions = oAction.listElseActions;
		nodesActions = eltElse.childNodes;
		nLength = nodesActions.length;
		for (i = 0; i < nLength; i++)
		{
			var eltChild = nodesActions[i];
			if (eltChild.nodeType == 1)
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueIF()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		var bConditionOk = GetExpr(this.eltIf);

		this.oCurrentAction = bConditionOk ? this.listActions.pFirst : this.listElseActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadIFSCORE(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sSource = eltAction.getAttribute("oid");
	oAction.sCondition = eltAction.getAttribute("condition");

	oAction.eltScore = eltAction.selectSingleNode("score");

	oAction.listActions = new List;
	oAction.listElseActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "ELSE" && eltChild.tagName != "score")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	var eltElse = eltAction.selectSingleNode("ELSE");
	if (eltElse != null)
	{
		listActions = oAction.listElseActions;
		nodesActions = eltElse.childNodes;
		nLength = nodesActions.length;
		for (i = 0; i < nLength; i++)
		{
			var eltChild = nodesActions[i];
			if (eltChild.nodeType == 1)
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueIFSCORE()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		var sCurrentScore = (this.sSource == "" ?
			GetObjectiveScore(this.sObjectiveId) :
			GetObjectiveSourceScore(this.sObjectiveId, this.sSource));
		var nCurrentScore = (sCurrentScore == "" || sCurrentScore == null) ? 0 : parseFloat(sCurrentScore);

		var sScore = GetExpr(this.eltScore);
		var nScore = (sScore == "" || sScore == null) ? 0 : parseFloat(sScore);

		var bConditionOk;
		switch (this.sCondition)
		{
			case "lt":
				bConditionOk = nCurrentScore < nScore ? true : false;
				break;
			case "gt":
				bConditionOk = nCurrentScore > nScore ? true : false;
				break;
			case "eq":
				bConditionOk = nCurrentScore == nScore ? true : false;
				break;
			case "le":
				bConditionOk = nCurrentScore <= nScore ? true : false;
				break;
			case "ge":
				bConditionOk = nCurrentScore >= nScore ? true : false;
				break;
			case "ne":
				bConditionOk = nCurrentScore != nScore ? true : false;
				break;
			default:
				bConditionOk = false;
		}
		this.oCurrentAction = bConditionOk ? this.listActions.pFirst : this.listElseActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadIFSUCCESSSTATUS(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sStatus = eltAction.getAttribute("status");

	oAction.listActions = new List;
	oAction.listElseActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "ELSE" && eltChild.tagName != "if")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	var eltElse = eltAction.selectSingleNode("ELSE");
	if (eltElse != null)
	{
		listActions = oAction.listElseActions;
		nodesActions = eltElse.childNodes;
		nLength = nodesActions.length;
		for (i = 0; i < nLength; i++)
		{
			var eltChild = nodesActions[i];
			if (eltChild.nodeType == 1)
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueIFSUCCESSSTATUS()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		var sCurrentStatus = GetObjectiveSuccessStatus(this.sObjectiveId, this.sStatus);
		this.oCurrentAction = (sCurrentStatus == this.sStatus) ? this.listActions.pFirst : this.listElseActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadIFCOMPLETIONSTATUS(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sStatus = eltAction.getAttribute("status");

	oAction.listActions = new List;
	oAction.listElseActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			if (eltChild.tagName != "ELSE" && eltChild.tagName != "if")
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	var eltElse = eltAction.selectSingleNode("ELSE");
	if (eltElse != null)
	{
		listActions = oAction.listElseActions;
		nodesActions = eltElse.childNodes;
		nLength = nodesActions.length;
		for (i = 0; i < nLength; i++)
		{
			var eltChild = nodesActions[i];
			if (eltChild.nodeType == 1)
			{
				var oChildAction = new Action;
				oChildAction.Load(eltChild);
				listActions.Add(oChildAction);
			}
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueIFCOMPLETIONSTATUS()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		var sCurrentStatus = GetObjectiveCompletionStatus(this.sObjectiveId, this.sStatus);
		this.oCurrentAction = (sCurrentStatus == this.sStatus) ? this.listActions.pFirst : this.listElseActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadJAVASCRIPT(oAction, eltAction)
{
	oAction.sText = eltAction.getAttribute("text");
}
function Action_ContinueJAVASCRIPT()
{
	eval(this.sText);
	return this.pNext;
}
function Action_LoadJUMP(oAction, eltAction)
{
	oAction.sLink = eltAction.getAttribute("link");
}
function Action_ContinueJUMP()
{
	var sLink = EvalExpr(this.sLink, true);
	window.open(sLink);
	return this.pNext;
}
function Action_LoadMEDIAPLAY(oAction, eltAction)
{
	oAction.sPlay = eltAction.getAttribute("play");
	if (oAction.sPlay == "1")
	{
		oAction.sSoundSrc = eltAction.getAttribute("src");
		if (oAction.sSoundSrc == "")
			oAction.sTargetId = eltAction.getAttribute("pid");
	}
}
function Action_ContinueMEDIAPLAY()
{
	if (this.sPlay == "1")
	{
		var sSoundSrc = this.sSoundSrc;
		var sSoundId = "";

		if (this.sSoundSrc == "")
		{
			var oObject = GetObjectById(this.sTargetId);
			if (oObject)
			{
				sSoundSrc = oObject.getAttribute("soundsrc");
				sSoundId = this.sTargetId;
			}
		}

		if (sSoundSrc != null &&
			sSoundSrc != "")
			PlaySound(sSoundSrc, sSoundId);
	}
	else
	{
		if (g_bSoundOn)
			StopSound();
	}
	return this.pNext;
}
function Action_LoadMETHOD(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sTargetType = null;
	oAction.sMethod = eltAction.getAttribute("method");

	var oArg = new Object;
	oArg.pid = oAction.sTargetId;

	var oParamNodes = eltAction.selectNodes("param");
	for (var i = 0; i < oParamNodes.length; i++)
	{
		var oParamNode = oParamNodes[i];
		var sName = oParamNode.getAttribute("name");
		var sValue = oParamNode.getAttribute("value");
		oArg[sName] = sValue;
	}

	oAction.oArg = oArg;

	oAction.nStartTime = 0;
}
function Action_ContinueMETHOD()
{
	var sType = this.sTargetType;
	if (sType == null)
	{
		var oObject = GetObjectById(this.sTargetId);
		if (oObject)
			sType = oObject.getAttribute("type");
	}

	CallMethod(sType, this.sMethod, this.oArg);

	return this.pNext;
}
function Action_LoadMOVE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAdditive = eltAction.getAttribute("additive");
	oAction.sDur = eltAction.getAttribute("dur");

	oAction.eltEndX = eltAction.selectSingleNode("x");
	oAction.eltEndY = eltAction.selectSingleNode("y");

	oAction.nStartTime = 0;
}
function Action_ContinueMOVE()
{
	var sTargetId = this.sTargetId;
	var oDisplayObject = FindDisplayObject(sTargetId);

	if (this.nStartTime == 0)
	{
		/* MoveStart */
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		CancelMoveDisplayObject(sTargetId);
		this.bCancelled = false;

		if (oDisplayObject)
		{
			oDisplayObject.oActionMove = this;
			this.nStartX = oDisplayObject.nX;
			this.nStartY = oDisplayObject.nY;
		}

		if (this.eltEndX != undefined)
		{
			this.nEndX = parseInt(GetExpr(this.eltEndX));
			this.nEndY = parseInt(GetExpr(this.eltEndY));
		}
		else
		{
			this.nEndX = parseInt(this.sEndX);
			this.nEndY = parseInt(this.sEndY);
		}

		if (this.sAdditive == "sum")
		{
			this.nEndX += this.nStartX;
			this.nEndY += this.nStartY;
		}

		this.nDistanceX = this.nEndX - this.nStartX;
		this.nDistanceY = this.nEndY - this.nStartY;
	}

	if (this.bCancelled)
	{
		this.nStartTime = 0;
		return this.pNext;
	}

	var oTarget = document.getElementById(sTargetId);

	if (g_nCurrentTime >= this.nEndTime)
	{
		/* MoveDone */
		var nRX = 0;
		var nRY = 0;
		if (oDisplayObject)
		{
			oDisplayObject.nX = this.nEndX;
			oDisplayObject.nY = this.nEndY;
			oDisplayObject.oActionMove = null;

			nRX = oDisplayObject.nRX;
			nRY = oDisplayObject.nRY;
		}
		if (oTarget)
		{
			var oStyle = oTarget.style;
			oStyle.left = this.nEndX + nRX + "px";
			oStyle.top = this.nEndY + nRY + "px";
		}
		this.nStartTime = 0;
		return this.pNext;
	}

	/* Moving */
	var nScale = (g_nCurrentTime - this.nStartTime) / this.nDur;
	var nPosX = parseInt(this.nStartX + this.nDistanceX * nScale);
	var nPosY = parseInt(this.nStartY + this.nDistanceY * nScale);

	var nRX = 0;
	var nRY = 0;
	if (oDisplayObject)
	{
		oDisplayObject.nX = nPosX;
		oDisplayObject.nY = nPosY;

		nRX = oDisplayObject.nRX;
		nRY = oDisplayObject.nRY;
	}
	if (oTarget)
	{
		var oStyle = oTarget.style;
		oStyle.left = nPosX + nRX + "px";
		oStyle.top = nPosY + nRY + "px";
	}
	return this;
}
function Action_LoadMSGBOX(oAction, eltAction)
{
	oAction.eltValue = eltAction.selectSingleNode("value");
}
function Action_ContinueMSGBOX()
{
	var sValue = GetExpr(this.eltValue);

	Pause();
	alert(sValue);
	Resume();

	return this.pNext;
}
function Action_LoadNAVIGATION(oAction, eltAction)
{
	oAction.sTargets = eltAction.getAttribute("targets");
	oAction.sAction = eltAction.getAttribute("action");
}
function Action_ContinueNAVIGATION()
{
	var oArg = new Object;
	oArg.sTargets = this.sTargets;
	oArg.sAction = this.sAction;

	HandleEvt("EVENT_NAVIGATION", oArg);

	return this.pNext;
}
function Action_LoadPAR(oAction, eltAction)
{
	oAction.listActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			var oChildAction = new Action;
			oChildAction.Load(eltChild);
			listActions.Add(oChildAction);
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinuePAR()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		for (var oAction = this.listActions.pFirst; oAction != null; oAction = oAction.pNext)
			oAction.bPARComplete = false;
	}

	var bContinue = false;
	for (var oAction = this.listActions.pFirst; oAction != null; oAction = oAction.pNext)
	{
		if (oAction.bPARComplete == false)
		{
			if (oAction.Continue() == oAction)
				bContinue = true;
			else
				oAction.bPARComplete = true;
		}
	}
	if (bContinue)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadPRINT(oAction, eltAction)
{
}
function Action_ContinuePRINT()
{
	window.print();
	return this.pNext;
}
function Action_LoadRETURN(oAction, eltAction)
{
}
function Action_ContinueRETURN()
{
	if (g_sReturnFrameId != null)
	{
		var sFrameId = g_sReturnFrameId;
		g_sReturnFrameId = null;

		var oNewFrame = g_oSlides.selectSingleNode("slide/frames/frame[@id=\""+sFrameId+"\"]");
		if (oNewFrame != null)
		{
			var oNewSlide = oNewFrame.parentNode.parentNode;
			if (oNewSlide.getAttribute("id") == g_oSlide.getAttribute("id"))
				OpenFrame(oNewFrame, false);
			else
				OpenSlide(oNewSlide, sFrameId);
		}
	}
	return this.pNext;
}
function Action_LoadROTATE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAdditive = eltAction.getAttribute("additive");
	oAction.sDur = eltAction.getAttribute("dur");

	oAction.eltEndR = eltAction.selectSingleNode("angle");

	oAction.nStartTime = 0;
}
function Action_ContinueROTATE()
{
	var sTargetId = this.sTargetId;
	var oDisplayObject = FindDisplayObject(sTargetId);
	var oTarget = document.getElementById(sTargetId);

	if (this.nStartTime == 0)
	{
		/* RotateStart */
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		CancelRotateDisplayObject(sTargetId);
		this.bCancelled = false;

		if (oDisplayObject)
		{
			oDisplayObject.oActionRotate = this;

			this.nStartR = oDisplayObject.nR;

			this.nEndR = parseInt(GetExpr(this.eltEndR));

			if (this.sAdditive == "sum")
				this.nEndR += this.nStartR;

			this.nDistance = this.nEndR - this.nStartR;
		}
	}

	if (this.bCancelled)
	{
		this.nStartTime = 0;
		return this.pNext;
	}

	if (g_nCurrentTime >= this.nEndTime)
	{
		/* RotateDone */
		var nR = this.nEndR;

		if (oDisplayObject)
		{
			oDisplayObject.nR = nR;
			oDisplayObject.oActionRotate = null;
		}
		
		if(oTarget && oDisplayObject)
		{
			if(!g_isMSIE11 && !g_isMSIE)
			{
				switch(g_sCSSPrefix)
				{
					case "ms":
					{
						oTarget.style.msTransformOrigin = "50% 50%";
						oTarget.style.msTransform = "rotate(" + nR + "deg)";
						break
					}
					case "webkit":
					{
						oTarget.style.webkitTransformOrigin = "50% 50%";
						oTarget.style.webkitTransform = "rotate(" + nR + "deg)";
						break
					}
					case "moz":
					{
						oTarget.style.mozTransformOrigin = "50% 50%";
						oTarget.style.mozTransform = "rotate(" + nR + "deg)";
						break
					}
					case "o":
					{
						oTarget.style.oTransformOrigin = "50% 50%";
						oTarget.style.oTransform = "rotate(" + nR + "deg)";
						break
					}
				}
				oTarget.style.transformOrigin = "50% 50%";
				oTarget.style.transform = "rotate(" + nR + "deg)";
			}
			else
			{
				var oTFilters = null;
				try
				{
					oTFilters = oTarget.filters;
				}
				catch(e)
				{}
				if(oTFilters!=null)
				{
					var x = oDisplayObject.nX;
					var y = oDisplayObject.nY;
					var w = oDisplayObject.nW;
					var h = oDisplayObject.nH;
		
					var flRad = parseFloat(nR) * (2 * Math.PI) / 360;
					var flCos = Math.cos(flRad);
					var flSin = Math.sin(flRad);
		
					var M11 = flCos;
					var M12 = -flSin;
					var M21 = flSin;
					var M22 = flCos;
		
					var flAbsSin = (flSin >= 0 ? flSin : -flSin);
					var flAbsCos = (flCos >= 0 ? flCos : -flCos);
		
					var cx = parseFloat(w) / 2;
					var cy = parseFloat(h) / 2;
		
					var offsetx = -cx*flAbsCos - cy*flAbsSin + cx;
					var offsety = -cx*flAbsSin - cy*flAbsCos + cy;
		
					x = parseFloat(x) + parseFloat(offsetx);
					y = parseFloat(y) + parseFloat(offsety);
		
					oDisplayObject.nRX = parseInt(x) - parseInt(oDisplayObject.nX);
					oDisplayObject.nRY = parseInt(y) - parseInt(oDisplayObject.nY);
					
					if (oTFilters.length == 0)
						oTarget.style.filter = "progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand')";
		
					var oFilter = {};
					try
					{
						oFilter = oTFilters.item("DXImageTransform.Microsoft.Matrix");
					}
					catch (e)
					{
						oTarget.style.filter += " progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand')";
						try
						{
							oTFilters = oTarget.filters;
							oFilter = oTFilters.item("DXImageTransform.Microsoft.Matrix");
						}
						catch(e)
						{}
					}
					if(oFilter==null) oFilter = {};

					oFilter.M11 = M11;
					oFilter.M12 = M12;
					oFilter.M21 = M21;
					oFilter.M22 = M22;
		
					var oStyle = oTarget.style;
					oStyle.left = x;
					oStyle.top = y;
				}
			}
		}

		this.nStartTime = 0;
		return this.pNext;
	}

	/* Rotating */
	var nScale = (g_nCurrentTime - this.nStartTime) / this.nDur;
	var nR = parseInt(this.nStartR + this.nDistance * nScale);

	if (oDisplayObject)
	{
		oDisplayObject.nR = nR;
	}

	if(oTarget && oDisplayObject)
	{
		if(!g_isMSIE11 && !g_isMSIE)
		{
			switch(g_sCSSPrefix)
			{
				case "ms":
				{
					oTarget.style.msTransformOrigin = "50% 50%";
					oTarget.style.msTransform = "rotate(" + nR + "deg)";
					break
				}
				case "webkit":
				{
					oTarget.style.webkitTransformOrigin = "50% 50%";
					oTarget.style.webkitTransform = "rotate(" + nR + "deg)";
					break
				}
				case "moz":
				{
					oTarget.style.mozTransformOrigin = "50% 50%";
					oTarget.style.mozTransform = "rotate(" + nR + "deg)";
					break
				}
				case "o":
				{
					oTarget.style.oTransformOrigin = "50% 50%";
					oTarget.style.oTransform = "rotate(" + nR + "deg)";
					break
				}
			}
			oTarget.style.transformOrigin = "50% 50%";
			oTarget.style.transform = "rotate(" + nR + "deg)";
		}
		else
		{
			var oRFilters = null;
			try
			{
				oRFilters = oTarget.filters;
			}
			catch(e)
			{}
			if(oRFilters!=null)
			{
				var x = oDisplayObject.nX;
				var y = oDisplayObject.nY;
				var w = oDisplayObject.nW;
				var h = oDisplayObject.nH;
		
				var flRad = parseFloat(nR) * (2 * Math.PI) / 360;
				var flCos = Math.cos(flRad);
				var flSin = Math.sin(flRad);
		
				var M11 = flCos;
				var M12 = -flSin;
				var M21 = flSin;
				var M22 = flCos;
		
				var flAbsSin = (flSin >= 0 ? flSin : -flSin);
				var flAbsCos = (flCos >= 0 ? flCos : -flCos);
		
				var cx = parseFloat(w) / 2;
				var cy = parseFloat(h) / 2;
		
				var offsetx = -cx*flAbsCos - cy*flAbsSin + cx;
				var offsety = -cx*flAbsSin - cy*flAbsCos + cy;
		
				x = parseFloat(x) + parseFloat(offsetx);
				y = parseFloat(y) + parseFloat(offsety);
		
				oDisplayObject.nRX = parseInt(x) - parseInt(oDisplayObject.nX);
				oDisplayObject.nRY = parseInt(y) - parseInt(oDisplayObject.nY);
		
				var oStyle = oTarget.style;
		
				var sFilter = "DXImageTransform.Microsoft.Matrix";
		
				var oFilter = null;
				if (oRFilters.length != 0)
					if (oStyle.filter.indexOf(sFilter) != -1)
						oFilter = oRFilters.item(sFilter);
		
				if (oFilter == null)
				{
					oStyle.filter += " progid:"+sFilter+"(sizingMethod='auto expand')";
					try
					{
						oRFilters = oTarget.filters;
						oFilter = oRFilters.item(sFilter);
					}
					catch(e)
					{}
					
				}
				if(oFilter==null) oFilter = {};

				oFilter.M11 = M11;
				oFilter.M12 = M12;
				oFilter.M21 = M21;
				oFilter.M22 = M22;
		
				oStyle.left = x;
				oStyle.top = y;
			}
		}
	}
	return this;
}
function Action_LoadSETSCORE(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sSourceId = eltAction.getAttribute("oid");
	oAction.sAdditive = eltAction.getAttribute("additive");

	oAction.eltScore = eltAction.selectSingleNode("score");
}
function Action_ContinueSETSCORE()
{
	var nScore = parseFloat(GetExpr(this.eltScore));

	SetObjectiveScore(this.sObjectiveId, this.sSourceId, this.sAdditive, nScore);

	return this.pNext;
}
function Action_LoadSETCOMPLETIONSTATUS(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sStatus = eltAction.getAttribute("status");
}
function Action_ContinueSETCOMPLETIONSTATUS()
{
	SetObjectiveCompletionStatus(this.sObjectiveId, this.sStatus);

	return this.pNext;
}
function Action_LoadSETSUCCESSSTATUS(oAction, eltAction)
{
	oAction.sObjectiveId = eltAction.getAttribute("pid");
	oAction.sStatus = eltAction.getAttribute("status");
}
function Action_ContinueSETSUCCESSSTATUS()
{
	SetObjectiveSuccessStatus(this.sObjectiveId, this.sStatus);
	return this.pNext;
}
function Action_LoadSEQ(oAction, eltAction)
{
	oAction.listActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			var oChildAction = new Action;
			oChildAction.Load(eltChild);
			listActions.Add(oChildAction);
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueSEQ()
{
	if (this.nStartTime == 0)
	{
		this.nStartTime = g_nCurrentTime;

		this.oCurrentAction = this.listActions.pFirst;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadSIZE(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAdditive = eltAction.getAttribute("additive");
	oAction.sDur = eltAction.getAttribute("dur");

	oAction.eltEndW = eltAction.selectSingleNode("w");
	oAction.eltEndH = eltAction.selectSingleNode("h");

	oAction.nStartTime = 0;
}
function Action_ContinueSIZE()
{
	if (this.nStartTime == 0)
	{
		/* SizeStart */
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		CancelSizeDisplayObject(this.sTargetId);
		this.bCancelled = false;

		var oDisplayObject = FindDisplayObject(this.sTargetId);
		if (oDisplayObject)
		{
			oDisplayObject.oActionSize = this;

			this.nStartW = oDisplayObject.nW;
			this.nStartH = oDisplayObject.nH;
		}

		if (this.eltEndW != undefined)
		{
			this.nEndW = parseInt(GetExpr(this.eltEndW));
			this.nEndH = parseInt(GetExpr(this.eltEndH));
		}
		else
		{
			this.nEndW = parseInt(this.sEndW);
			this.nEndH = parseInt(this.sEndH);
		}

		if (this.sAdditive == "sum")
		{
			this.nEndW += this.nStartW;
			this.nEndH += this.nStartH;
		}

		this.nDistanceW = this.nEndW - this.nStartW;
		this.nDistanceH = this.nEndH - this.nStartH;
	}

	if (this.bCancelled)
	{
		this.nStartTime = 0;
		return this.pNext;
	}

	var oDisplayObject = FindDisplayObject(this.sTargetId);
	var oTarget = document.getElementById(this.sTargetId);

	if (g_nCurrentTime >= this.nEndTime)
	{
		/* SizeDone */
		if (oDisplayObject)
		{
			oDisplayObject.nW = this.nEndW;
			oDisplayObject.nH = this.nEndH;
			oDisplayObject.oActionSize = null;
		}
		if (oTarget)
		{
			var oStyle = oTarget.style;
			oStyle.width = this.nEndW + "px";
			oStyle.height = this.nEndH + "px";

			var oChild = oTarget.firstChild;
			while (oChild != null && oChild.nodeType != 1)
				oChild = oChild.nextSibling;
			if (oChild != null)
			{
				oStyle = oChild.style;
				oStyle.width = this.nEndW + "px";
				oStyle.height = this.nEndH + "px";
			}
		}
		this.nStartTime = 0;
		return this.pNext;
	}

	/* Sizing */
	var nScale = (g_nCurrentTime - this.nStartTime) / this.nDur;
	var nPosW = parseInt(this.nStartW + this.nDistanceW * nScale);
	var nPosH = parseInt(this.nStartH + this.nDistanceH * nScale);

	if (oDisplayObject)
	{
		oDisplayObject.nW = nPosW;
		oDisplayObject.nH = nPosH;
	}
	if (oTarget)
	{
		var oStyle = oTarget.style;
		oStyle.width = nPosW + "px";
		oStyle.height = nPosH + "px";

		var oChild = oTarget.firstChild;
		while (oChild != null && oChild.nodeType != 1)
			oChild = oChild.nextSibling;
		if (oChild != null)
		{
			oStyle = oChild.style;
			oStyle.width = nPosW + "px";
			oStyle.height = nPosH + "px";
		}
	}

	return this;
}
function Action_LoadTIMER(oAction, eltAction)
{
	oAction.sDur = eltAction.getAttribute("mil");

	oAction.listActions = new List;

	var listActions = oAction.listActions;
	var nodesActions = eltAction.childNodes;
	var nLength = nodesActions.length;
	for (var i = 0; i < nLength; i++)
	{
		var eltChild = nodesActions[i];
		if (eltChild.nodeType == 1)
		{
			var oChildAction = new Action;
			oChildAction.Load(eltChild);
			listActions.Add(oChildAction);
		}
	}

	oAction.nStartTime = 0;
}
function Action_ContinueTIMER()
{
	if (this.nStartTime == 0)
	{
		/* TimerStart */
		this.nDur = parseInt(this.sDur);

		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;

		this.oCurrentAction = this.listActions.pFirst;
	}

	if (parseInt(g_nCurrentTime) < parseInt(this.nEndTime))
	{
		/* Waiting */
		return this;
	}

	for (;;)
	{
		var oAction = this.oCurrentAction;
		if (oAction == null)
			break;

		this.oCurrentAction = oAction.Continue();
		if (this.oCurrentAction == oAction)
			break;
	}
	if (this.oCurrentAction)
		return this;

	/* TimerDone */
	this.nStartTime = 0;
	return this.pNext;
}
function Action_LoadVARIABLE(oAction, eltAction)
{
	oAction.sName = eltAction.getAttribute("name");
	oAction.sGlobal = eltAction.getAttribute("global");

	oAction.eltValue = eltAction.selectSingleNode("value");
}
function Action_ContinueVARIABLE()
{
	var sValue = GetExpr(this.eltValue);

	if (this.sGlobal == "1")
		g_arVars[this.sName] = sValue;
	else
		g_arSlideVars[this.sName] = sValue;

	return this.pNext;
}
function Action_LoadWAIT(oAction, eltAction)
{
	oAction.sCheck = eltAction.getAttribute("check");
	oAction.sDur = eltAction.getAttribute("mil");
	oAction.nStartTime = 0;
}
function Action_ContinueWAIT()
{
	if (this.nStartTime == 0)
	{
		/* WaitStart */
		this.nDur = parseInt(this.sDur);
		this.nStartTime = g_nCurrentTime;
		this.nEndTime = g_nCurrentTime + this.nDur;
	}

	if (this.sCheck == "0")
	{
		if (parseInt(g_nCurrentTime) >= parseInt(this.nEndTime))
		{
			/* WaitDone */
			this.nStartTime = 0;
			return this.pNext;
		}
	}

	/* Waiting */
	return this;
}
function Action_LoadZINDEX(oAction, eltAction)
{
	oAction.sTargetId = eltAction.getAttribute("pid");
	oAction.sAdditive = eltAction.getAttribute("additive");
	oAction.eltEndZ = eltAction.selectSingleNode("z");
}
function Action_ContinueZINDEX()
{
	var oDisplayObject = FindDisplayObject(this.sTargetId);
	var oTarget = document.getElementById(this.sTargetId);

	this.nEndZ = parseInt(GetExpr(this.eltEndZ));

	if (this.sAdditive == "sum")
	{
		if (oDisplayObject)
			this.nEndZ += oDisplayObject.nZ;
	}

	if (oDisplayObject)
		oDisplayObject.nZ = this.nEndZ;

	if (oTarget)
		oTarget.style.zIndex = this.nEndZ;

	return this.pNext;
}

/* DISPLAYOBJECT */
function DisplayObject(sId, nX, nY, nW, nH, nR, nZ)
{
	this.sId = sId;
	this.nX = parseInt(nX);
	this.nY = parseInt(nY);
	this.nW = parseInt(nW);
	this.nH = parseInt(nH);
	this.nR = parseInt(nR == null ? 0 : nR);
	this.nRX = 0;
	this.nRY = 0;
	this.nZ = parseInt(nZ);
}
function FindDisplayObject(sId)
{
	var oDisplayObject = null;
	for (var oExistingDisplayObject = g_listDisplayObjects.pLast; oExistingDisplayObject; oExistingDisplayObject = oExistingDisplayObject.pPrevious)
	{
		if (oExistingDisplayObject.sId == sId)
		{
			oDisplayObject = oExistingDisplayObject;
			break;
		}
	}
	return oDisplayObject;
}
function AddDisplayObject(sId, nX, nY, nW, nH, nR, nZ)
{
	var oDisplayObject = new DisplayObject(sId, nX, nY, nW, nH, nR, nZ);
	g_listDisplayObjects.Add(oDisplayObject);
	return oDisplayObject;
}
function SetDisplayObject(oDisplayObject, nX, nY, nW, nH, nR, nRX, nRY, nZ)
{
	oDisplayObject.nX = parseInt(nX);
	oDisplayObject.nY = parseInt(nY);
	oDisplayObject.nW = parseInt(nW);
	oDisplayObject.nH = parseInt(nH);
	oDisplayObject.nR = parseInt(nR == null ? 0 : nR);
	oDisplayObject.nRX = parseInt(nRX);
	oDisplayObject.nRY = parseInt(nRY);
	oDisplayObject.nZ = parseInt(nZ);
}
function CancelMoveDisplayObject(sId)
{
	var oDisplayObject = FindDisplayObject(sId);
	if (oDisplayObject)
	{
		var oActionMove = oDisplayObject.oActionMove;
		if (oActionMove != null)
			oActionMove.bCancelled = true;
	}
}
function CancelMoveAllDisplayObjects()
{
	for (var oDisplayObject = g_listDisplayObjects.pFirst; oDisplayObject; oDisplayObject = oDisplayObject.pNext)
	{
		var oActionMove = oDisplayObject.oActionMove;
		if (oActionMove != null)
			oActionMove.bCancelled = true;
	}
}
function CancelSizeDisplayObject(sId)
{
	var oDisplayObject = FindDisplayObject(sId);
	if (oDisplayObject)
	{
		var oActionSize = oDisplayObject.oActionSize;
		if (oActionSize != null)
			oActionSize.bCancelled = true;
	}
}
function CancelSizeAllDisplayObjects()
{
	for (var oDisplayObject = g_listDisplayObjects.pFirst; oDisplayObject; oDisplayObject = oDisplayObject.pNext)
	{
		var oActionSize = oDisplayObject.oActionSize;
		if (oActionSize != null)
			oActionSize.bCancelled = true;
	}
}
function CancelRotateDisplayObject(sId)
{
	var oDisplayObject = FindDisplayObject(sId);
	if (oDisplayObject)
	{
		var oActionRotate = oDisplayObject.oActionRotate;
		if (oActionRotate != null)
			oActionRotate.bCancelled = true;
	}
}
function CancelRotateAllDisplayObjects()
{
	for (var oDisplayObject = g_listDisplayObjects.pFirst; oDisplayObject; oDisplayObject = oDisplayObject.pNext)
	{
		var oActionRotate = oDisplayObject.oActionRotate;
		if (oActionRotate != null)
			oActionRotate.bCancelled = true;
	}
}

/* EXPRESSIONS */
function EvalExpr(sExpr, bEval)
{
	if (parseInt(sExpr) + "" == sExpr)
		return sExpr;

	var sValue = sExpr;
	sValue = ReplacePropertiesInStr(sValue);
	sValue = ReplaceVariablesInStr(sValue);

	if (bEval)
	{
		try
		{
			sValue = eval(sValue);
		}
		catch (e)
		{
		}
	}
	return sValue;
}
function GetExpr(eltValue)
{
	var sValue = "";
	if (eltValue != null)
	{
		var eltChild = eltValue.firstChild;
		while (eltChild != null && eltChild.nodeType != 1)
			eltChild = eltChild.nextSibling;
		if (eltChild != null)
			sValue = Expr(eltChild);
	}
	return sValue;
}
function Expr(oExpr)
{
	var oFn;
	switch (oExpr.tagName)
	{
		case "num":
			oFn = ExprNum;
			break;
		case "bool":
			oFn = ExprBool;
			break;
		case "str":
			oFn = ExprStr;
			break;
		case "var":
			oFn = ExprVar;
			break;
		case "propget":
			oFn = ExprPropGet;
			break;
		case "add":
			oFn = ExprAdd;
			break;
		case "sub":
			oFn = ExprSub;
			break;
		case "mul":
			oFn = ExprMul;
			break;
		case "div":
			oFn = ExprDiv;
			break;
		case "neg":
			oFn = ExprNeg;
			break;
		case "not":
			oFn = ExprNot;
			break;
		case "lt":
			oFn = ExprLt;
			break;
		case "gt":
			oFn = ExprGt;
			break;
		case "le":
			oFn = ExprLe;
			break;
		case "ge":
			oFn = ExprGe;
			break;
		case "eq":
			oFn = ExprEq;
			break;
		case "ne":
			oFn = ExprNe;
			break;
		case "and":
			oFn = ExprAnd;
			break;
		case "or":
			oFn = ExprOr;
			break;

		case "sin":
			oFn = ExprMathSin;
			break;
		case "cos":
			oFn = ExprMathCos;
			break;
		case "random":
			oFn = ExprMathRandom;
			break;
		case "pi":
			oFn = ExprMathPI;
			break;
		default:
			oFn = null;
	}
	return oFn == null ? null : oFn(oExpr);
}
function ExprNum(oExpr)
{
	var s = oExpr.getAttribute("val");
	return s;
}
function ExprBool(oExpr)
{
	var s = oExpr.getAttribute("val");
	return (s == "true" ? true : false);
}
function ExprStr(oExpr)
{
	return oExpr.getAttribute("val");
}
function ExprVar(oExpr)
{
	var s = oExpr.getAttribute("val");
	s = s.substr(1); /* Remove leading # */
	return (IsSlideVar(s) ? g_arSlideVars[s] : g_arVars[s]);
}
function ExprPropGet(oExpr)
{
	var sObjectId = (oExpr.selectSingleNode("id["+g_nFirst+"]")).getAttribute("val");
	var sProperty = (oExpr.selectSingleNode("id["+(g_nFirst+1)+"]")).getAttribute("val");
	return (GetObjectProperty(sObjectId, sProperty));
}
function ExprAdd(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	var flL = parseFloat(sL);
	var flR = parseFloat(sR);

	if (!isNaN(flL) && !isNaN(flR))
		return (flL + flR);

	return String(sL) + String(sR);
}
function ExprSub(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;

	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;

	var sR = Expr(oR);
	if (sR == null)
		return null;

	return (parseFloat(sL) - parseFloat(sR));
}
function ExprMul(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return (parseFloat(sL) * parseFloat(sR));
}
function ExprDiv(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return (parseFloat(sL) / parseFloat(sR));
}
function ExprNeg(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var s = Expr(oL);
	if (s == null)
		return null;

	return (-parseFloat(s));
}
function ExprNot(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var s = Expr(oL);
	if (s == null)
		return null;

	return (!s);
}
function ExprAnd(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return (sL && sR);
}
function ExprOr(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return (sL || sR);
}
function ExprLt(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return parseFloat(sL) < parseFloat(sR);
}
function ExprGt(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return parseFloat(sL) > parseFloat(sR);
}
function ExprLe(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return parseFloat(sL) <= parseFloat(sR);
}
function ExprGe(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return parseFloat(sL) >= parseFloat(sR);
}
function ExprEq(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return sL == sR;
}
function ExprNe(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var sL = Expr(oL);
	if (sL == null)
		return null;

	var oR = oL.nextSibling;
	while (oR != null && oR.nodeType != 1)
		oR = oR.nextSibling;
	var sR = Expr(oR);
	if (sR == null)
		return null;

	return sL != sR;
}
function ExprMathSin(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var s = Expr(oL);
	if (s == null)
		return null;

	s = Math.sin(s);

	return s;
}
function ExprMathCos(oExpr)
{
	var oL = oExpr.firstChild;
	while (oL != null && oL.nodeType != 1)
		oL = oL.nextSibling;
	var s = Expr(oL);
	if (s == null)
		return null;

	s = Math.cos(s);

	return s;
}
function ExprMathRandom(oExpr)
{
	return Math.random();
}
function ExprMathPI(oExpr)
{
	return Math.PI;
}
function ProcessActions(oEvent)
{
	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);
	Thread_Load(oThread, oEvent.childNodes);

	g_nCurrentTime = (new Date()).valueOf();

	var oAction = Thread_Continue(oThread);
	if (oAction == null)
	{
		g_listThreads.Subtract(oThread);
		RemoveFrameThreads();
	}
	else
	{
		if (g_nTimeoutId)
			clearTimeout(g_nTimeoutId);
		RemoveFrameThreads();
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
	}
}
function RemoveFrameThreads()
{
	for (var oThread = g_listThreads.pFirst; oThread != null; )
	{
		var oNextThread = oThread.pNext;
		if (oThread.nFrameNum != g_nFrameNum)
			g_listThreads.Subtract(oThread);
		oThread = oNextThread;
	}
}
function GetResolution2()
{
	return 1;

	if (g_nCurrentTime == 0)
	{
		g_nCurrentTime = (new Date()).valueOf();
		g_nSlideCurrentTime = g_nCurrentTime;
	}

	var bHiResEvtHandler = false;
	for (var oEvtHandler = g_listEvtHandlers.pFirst; oEvtHandler != null; oEvtHandler = oEvtHandler.pNext)
	{
		if (oEvtHandler.sEvt == "EVENT_TIMER")
		{
			bHiResEvtHandler = true;
			break;
		}
	}

	var nNearTime = g_nCurrentTime + 60000;
	if (bHiResEvtHandler)
		nNearTime = g_nCurrentTime + 100;

	for (var oThread = g_listThreads.pFirst; oThread != null; oThread = oThread.pNext)
	{
		for (var oAction = oThread.listActions.pFirst; oAction != null; oAction = oAction.pNext)
		{
			var nTimeActionNearTime = oAction.GetNearTime();
			if (nTimeActionNearTime >= 0)
				if (nTimeActionNearTime < nNearTime)
				{
					nNearTime = nTimeActionNearTime;
					if (nNearTime <= g_nCurrentTime + 100)
						break;
				}
		}
		if (nNearTime <= g_nCurrentTime + 100)
			break;
	}

	return nNearTime >= 0 ? nNearTime - g_nCurrentTime : 10;
}
function TimerFunction2()
{
	clearTimeout(g_nTimeoutId);
	g_nTimeoutId = 0;
	if (g_bPause == false)
	{
		g_nCurrentTime = (new Date()).valueOf();
		g_nSlideCurrentTime = g_nCurrentTime;

		HandleEvt("EVENT_TIMER", null);

		var nOldFrameNum = g_nFrameNum;
		for (var oThread = g_listThreads.pFirst; oThread != null; )
		{
			var pNext = oThread.pNext;

			var oAction = Thread_Continue(oThread);
			if (nOldFrameNum != g_nFrameNum)
			{
				RemoveFrameThreads();
				break;
			}
			if (oAction == null)
				g_listThreads.Subtract(oThread);

			oThread = pNext;
		}

		if (g_listThreads.pFirst)
			g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
	}
}
function processEvent(sResponseId)
{
	if (g_bPause == false)
	{
		var oResponse = GetResponseById(sResponseId);
		if (oResponse != null)
		{
			if (g_isMSIE && window.event != null)
			{
				if(window.event.type=="dblclick")
				{
					if(document.selection && document.selection.empty)
					{
						document.selection.empty() ;
					}
					else if(window.getSelection)
					{
						var oSel = window.getSelection();
						if(oSel && oSel.removeAllRanges) oSel.removeAllRanges() ;
					}
				}
				window.event.cancelBubble = true;
			}
			ProcessActions(oResponse);
		}
		else
		{
			if(g_bDebugInfo) alert("?Response: "	+ sResponseId);
		}
	}
}
function processEventLR(sLeftResponseId, sRightResponseId, oEvt)
{
	if (g_bPause == false)
	{
		var oEvent = g_isMSIE ? window.event : oEvt;
		if (oEvent != null)
		{
			var sResponseId = null;

			if((g_isMSIE && oEvent.button == 1 ) || (!g_isMSIE && oEvent.button == 0))
			{
				if (sLeftResponseId != null)
				{
					sResponseId = sLeftResponseId;
				}
			} else {
				if(oEvent.button == 2)
				{
					if (sRightResponseId != null)
					{
						sResponseId = sRightResponseId;
					}
				}
			}

			if (sResponseId != null)
			{
				var oResponse = GetResponseById(sResponseId);
				if (oResponse != null)
				{
					if (g_isMSIE)
					{
						oEvent.cancelBubble = true;
					}
					else
					{
						oEvent.stopPropagation();
					}
					ProcessActions(oResponse);
				}
				else
				{
					alert("?Response: "	+ sResponseId);
				}
			}
		}
	}
}
function processEventKeyStr(oEvent, oSlideOrFrame, sResponseIds)
{
    var bHandled = false;

	var ar = sResponseIds.split(",");
	for (var i = 0; i < ar.length; i++)
	{
		var sResponseId = ar[i];

		var oResponse = oSlideOrFrame.selectSingleNode("RESPONSE[@name='"+ sResponseId +"']");
		if (oResponse == null)
		{
			alert("?Response: "	+ sResponseId);
			continue;
		}

		var nKey = oResponse.getAttribute("key");
		if (nKey != oEvent.keyCode)
			continue;

		var bShift = oResponse.getAttribute("shift");
		if (bShift != null)
		{
			if (oEvent.shiftKey != true)
				continue;
		}

		var bCtrl = oResponse.getAttribute("ctrl");
		if (bCtrl != null)
		{
			if (oEvent.ctrlKey != true)
				continue;
		}

		var bAlt = oResponse.getAttribute("alt");
		if (bAlt != null)
		{
			if (oEvent.altKey != true)
				continue;
		}

		if (g_isMSIE)
		{
			oEvent.cancelBubble = true;
		}
		else
		{
			oEvent.stopPropagation();
		}
		ProcessActions(oResponse);
		bHandled = true;
	}
	return bHandled;
}
function IsSlideVar(sName)
{
	var bSlideScope = false;
	for (var sTest in g_arSlideVars)
	{
		if (sTest == sName)
		{
			bSlideScope = true;
			break;
		}
	}
	return bSlideScope;
}

/* CREATETIMEACTIONS */
function CreateTimeActionAlpha(sTargetId, nBeginTime, nDuration, nStartAlpha, nEndAlpha)
{ 
	if (nBeginTime == null)
		nBeginTime = 0;

	var oAlpha = new Action;
	oAlpha.sType = "ALPHA";
	oAlpha.sTargetId = sTargetId;
	oAlpha.sStart = nStartAlpha;
	oAlpha.sEnd = nEndAlpha;
	oAlpha.sDur = nDuration;
	oAlpha.nStartTime = 0;
	oAlpha.Continue = Action_ContinueALPHA;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oAlpha);
	InsertWaitAtThreadBegin(oThread, parseInt(nBeginTime));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function CreateTimeActionMethod(sObjectType, sObjectMethod, nBeginTime, nTimeDistance, oArg)
{
	if (nBeginTime == null)
		nBeginTime = 0;

	var oMethod = new Action;
	oMethod.sType = "METHOD";
	oMethod.sTargetId = null;
	oMethod.sTargetType = sObjectType;
	oMethod.sMethod = sObjectMethod;
	oMethod.oArg = oArg;

	oMethod.nStartTime = 0;
	oMethod.Continue = Action_ContinueMETHOD;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oMethod);
	InsertWaitAtThreadBegin(oThread, parseInt(nBeginTime) + parseInt(nTimeDistance));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function CreateTimeActionMove(sTargetId, nBeginTime, nDuration, nStartX, nStartY, nEndX, nEndY)
{
	if (nBeginTime == null)
		nBeginTime = 0;

	/* Start */
	var oMove = new Action;
	oMove.sType = "MOVE";
	oMove.sTargetId = sTargetId;
	oMove.sEndX = nStartX;
	oMove.sEndY = nStartY;
	oMove.sAdditive = "";
	oMove.sDur = 0;
	oMove.nStartTime = 0;
	oMove.Continue = Action_ContinueMOVE;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oMove);
	oThread.oCurrentAction = oMove;

	/* End */
	var oMove = new Action;
	oMove.sType = "MOVE";
	oMove.sTargetId = sTargetId;
	oMove.nStartX = parseInt(nStartX);
	oMove.nStartY = parseInt(nStartY);
	oMove.sEndX = nEndX;
	oMove.sEndY = nEndY;
	oMove.sAdditive = "";
	oMove.sDur = nDuration;
	oMove.nStartTime = 0;
	oMove.Continue = Action_ContinueMOVE;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oMove);
	InsertWaitAtThreadBegin(oThread, parseInt(nBeginTime));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function CreateTimeActionSize(sTargetId, nBeginTime, nDuration, nStartW, nStartH, nEndW, nEndH)
{
	if (nBeginTime == null)
		nBeginTime = 0;

	var oSize = new Action;
	oSize.sType = "SIZE";
	oSize.sTargetId = sTargetId;

	oSize.nStartW = parseInt(nStartW);
	oSize.nStartH = parseInt(nStartH);
	oSize.sEndW = nEndW;
	oSize.sEndH = nEndH;
	oSize.sAdditive = "";
	oSize.sDur = nDuration;
	oSize.nStartTime = 0;
	oSize.Continue = Action_ContinueSIZE;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oSize);
	InsertWaitAtThreadBegin(oThread, parseInt(nBeginTime));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function CreateTimeActionDestroy(sTargetId, nTime)
{
	var oDestroy = new Action;
	oDestroy.sType = "DESTROY";
	oDestroy.sTargetId = sTargetId;
	oDestroy.Continue = Action_ContinueDESTROY;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oDestroy);
	InsertWaitAtThreadBegin(oThread, parseInt(nTime?nTime:0));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function CreateTimeActionDisplay(sTargetId, nBeginTime, bDisplay, nTransition, nDuration)
{
	if (nBeginTime == null)
		nBeginTime = 0;

	var oDisplay = new Action;
	oDisplay.sType = "DISPLAY";
	oDisplay.sTargetId = sTargetId;

	oDisplay.sDisplay = bDisplay ? "allbutnone" : "none";
	oDisplay.sTransition = nTransition;
	oDisplay.sDur = nDuration;
	oDisplay.nStartTime = 0;
	oDisplay.Continue = Action_ContinueDISPLAY;

	var oThread = new Thread;
	oThread.nFrameNum = g_nFrameNum;
	g_listThreads.Add(oThread);

	oThread.listActions.Add(oDisplay);
	InsertWaitAtThreadBegin(oThread, parseInt(nBeginTime));

	if (g_nTimeoutId == 0)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
}
function Pause()
{
	if (g_bPause == false)
	{
		g_bPause = true;
		g_nPauseBeginTime = (new Date()).valueOf();

		if (g_nTimeoutId != 0)
		{
			clearTimeout(g_nTimeoutId);
			g_nTimeoutId = 0;
		}
	}
}
function Resume()
{
	if (g_bPause == true)
	{
		g_bPause = false;

		g_nCurrentTime = (new Date()).valueOf();

		var nPauseEndTime = g_nCurrentTime;
		var nPauseDuration = nPauseEndTime - g_nPauseBeginTime;

		g_nSlideBeginTime += nPauseDuration;
		g_nSlideEndTime += nPauseDuration;
		g_nFrameBeginTime += nPauseDuration;

		for (var oThread = g_listThreads.pFirst; oThread != null; oThread = oThread.pNext)
			for (var oAction = oThread.listActions.pFirst; oAction != null; oAction = oAction.pNext)
				ResumeAction(oAction, nPauseDuration);

		if (g_nTimeoutId == 0)
			g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());
	}
}
function ResumeAction(oAction, nPauseDuration)
{
	if (oAction.nStartTime != null && oAction.nStartTime != 0)
		oAction.nStartTime += nPauseDuration;
	if (oAction.nEndTime != null && oAction.nEndTime != 0)
		oAction.nEndTime += nPauseDuration;

	if (oAction.listActions != null)
		for (var oChildAction = oAction.listActions.pFirst; oChildAction != null; oChildAction = oChildAction.pNext)
			ResumeAction(oChildAction, nPauseDuration);

	if (oAction.listElseActions != null)
		for (var oChildAction = oAction.listElseActions.pFirst; oChildAction != null; oChildAction = oChildAction.pNext)
			ResumeAction(oChildAction, nPauseDuration);
}
function CallConstructors(oObjects)
{
	try
	{
		var nObjects = oObjects.length;
		for (var i = 0; i < nObjects; i++)
		{
			var oObject = oObjects[i];
			var sType = oObject.getAttribute("type");
			if (sType != null)
			{
				var sTargetId = oObject.getAttribute("id");

				var oArg = new Object;
				oArg.pid = sTargetId;
				CallMethod(sType, "Constructor", oArg);
			}
		}
	}
	catch (e)
	{
		alert("CallConstructors: "+ e.description);
	}
}
function CallMethod(sType, sMethod, oArg)
{
	var oMethod = g_oMethods.selectSingleNode("method[@type=\""+ sType +"\" and @name=\""+ sMethod +"\"]");
	if (oMethod != null)
	{
		var sText = oMethod.text;

		var nBegin = sText.indexOf("{");
		var nEnd = sText.lastIndexOf("}");
		var sBody = sText.substring(nBegin + 1,	nEnd);

		try
		{
			if(window._cl_methods==null) window._cl_methods = {};
			if(window._cl_methods[sType + "_" + sMethod]==null) window._cl_methods[sType + "_" +sMethod] = new Function("argobj", sBody);
			window._cl_methods[sType + "_" +sMethod](oArg);
		}
		catch (e)
		{
			alert("CallMethod: "+ sType +" "+ sMethod +" "+ e.description);
		}
	}
}
function FireEvent(sTargetId, sResponseType)
{
	var oResponse = g_oSlides.selectSingleNode("slide/frames/frame/object[@id='"+sTargetId+"']/RESPONSE[@type='"+ sResponseType +"']");
	if (oResponse == null)
		oResponse = g_oMasters.selectSingleNode("slide/frames/frame/object[@id='"+sTargetId+"']/RESPONSE[@type='"+ sResponseType +"']");
	if (oResponse != null)
	{
		ProcessActions(oResponse);
	}
}
function EvtHandler(sEvt, sType, sTargetId)
{
	this.sEvt = sEvt;
	this.sType = sType;
	this.sTargetId = sTargetId;
	this.pNext = null;
}
function AddEvtHandler(sEvt, sType, sTargetId)
{
	var oEvtHandler = new EvtHandler(sEvt, sType, sTargetId);
	g_listEvtHandlers.Add(oEvtHandler);
	return oEvtHandler;
}
function HandleEvt(sEvt, oArg, sTargetId)
{
	for (var oEvtHandler = g_listEvtHandlers.pFirst; oEvtHandler != null; )
	{
		var pNext = oEvtHandler.pNext;
		if (oEvtHandler.sEvt == sEvt)
		{
			if(sEvt=="EVENT_OBJECT_ONLOAD" && sTargetId!=null && oEvtHandler.sTargetId!=sTargetId) 
			{
				oEvtHandler = pNext;
				continue;
			}
			var oMethod = g_oMethods.selectSingleNode("method[@type=\""+ oEvtHandler.sType +"\" and @name=\"HandleEvt\"]");
			var sText = oMethod.text;

			var nBegin = sText.indexOf("{");
			var nEnd = sText.lastIndexOf("}");
			var sBody = sText.substring(nBegin + 1,	nEnd);

			try
			{
				if (window._cl_eventHandlers==null) window._cl_eventHandlers = {};
				if (window._cl_eventHandlers[oEvtHandler.sType]==null)
				{
					var oFunction = new Function("oEvtHandler, oArg", sBody);
					window._cl_eventHandlers[oEvtHandler.sType] = new Function("oEvtHandler, oArg", sBody);
				}
				window._cl_eventHandlers[oEvtHandler.sType](oEvtHandler, oArg);
			}
			catch (e)
			{
				alert("HandleEvt: " + oEvtHandler.sType + "\n" + e.description);
			}
		}
		oEvtHandler = pNext;
	}
}
function TranslateFSCommand(sCommand, sArgs)
{
	var aSplittedArgs = sArgs.split("&");
	var oArgs = new Object;
	var sObjType = "agent_001";
	var sObjMethod = "Listener";
	var aPair;
	for(var i=0; i<aSplittedArgs.length; i++)
	{
		aPair = aSplittedArgs[i].split("=");
		if(aPair.length!=2)	continue;
		switch(aPair[0])
		{
			case "objID":
				oArgs.pid = aPair[1];
				break;
			case "action":
				oArgs.action = aPair[1];
				break;
			case "event":
				oArgs.ev = aPair[1];
				break;
			case "objtype":
				sObjType = aPair[1];
				break;
			case "objmethod":
				sObjMethod = aPair[1];
				break;
		}
	}
	CallMethod(sObjType, sObjMethod, oArgs);
	return true;
}
function GetObjectById(sObjectId)
{
	var oObject = g_oSlideFrame.selectSingleNode("object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	oObject = g_oSlide.selectSingleNode("frames/frame/object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	oObject = g_oSlides.selectSingleNode("slide/frames/frame/object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	var oObject = g_oMasterFrame.selectSingleNode("object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	oObject = g_oMaster.selectSingleNode("frames/frame/object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	oObject = g_oMasters.selectSingleNode("master/frames/frame/object[@id='"+ sObjectId +"']");
	if (oObject)
		return oObject;

	return null;
}
function GetResponseById(sResponseId)
{
	if(g_oSlideFrame==null) return null;
	var oResponse = g_oSlideFrame.selectSingleNode("object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	if(g_oSlide==null) return null;
	oResponse = g_oSlide.selectSingleNode("frames/frame/object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	if(g_oSlides==null) return null;
	oResponse = g_oSlides.selectSingleNode("slide/frames/frame/object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	if(g_oMasterFrame==null) return null;
	var oResponse = g_oMasterFrame.selectSingleNode("object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	if(g_oMaster==null) return null;
	oResponse = g_oMaster.selectSingleNode("frames/frame/object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	if(g_oMasters==null) return null;
	oResponse = g_oMasters.selectSingleNode("master/frames/frame/object/RESPONSE[@name='"+ sResponseId +"']");
	if (oResponse != null)
		return oResponse;

	return null;
}
function FindSlidesByText(sText)
{
	var nodesSlides = g_oModule.selectNodes("slides/slide[contains(frames/frame/object/data, '"+ sText +"')]");
	return nodesSlides;
}
function ShowObject(sTargetId, nTransition, nDuration)
{
	{
		var oObject = GetObjectById(sTargetId);
		if (oObject)
		{
			var sTextId = oObject.getAttribute("textid");
			if (sTextId != null && sTextId != sTargetId)
			{
				ShowObject(sTextId, nTransition, nDuration);
			}
		}
	}

	try
	{
		var oTarget = document.getElementById(sTargetId);
		if (oTarget != null)
		{
			if (oTarget.style.display != "inline" && oTarget.style.display != "block")
			{
				if (g_isMSIE)
				{
					oTarget.style.display = "inline";
				}
				else if (g_isFirefox)
				{
					if (nTransition)
					{
						var oObject = GetObjectById(sTargetId);
						if (oObject)
						{
							if (nTransition == 1)
							{
								nTransition = oObject.getAttribute("tranin");
								nDuration = oObject.getAttribute("durin");
							}
							else
							{
								nTransition -= 2;
								nDuration /= 1000;
							}

							if (nTransition == "12")
							{
								oTarget.style.opacity = 0;
							}
						}
					}
					oTarget.style.display = "block";
				}

				if (nTransition)
				{
					var oObject = GetObjectById(sTargetId);
					if (oObject)
					{
						if (nTransition == 1)
						{
							nTransition = oObject.getAttribute("tranin");
							nDuration = oObject.getAttribute("durin");
						}
						else
						{
							if (g_isMSIE)
							{
								nTransition -= 2;
								nDuration /= 1000;
							}
						}

						if (nTransition != null)
						{
							var oEFilters = null;
							try
							{
								oEFilters = oTarget.filters;
							}
							catch(e)
							{}
							if (((g_isMSIE && !g_isMSIE11) || (g_isMSIE11 && (nTransition==12 || nTransition==21 || nTransition==22))) && oEFilters!=null)
							{
								AttachMSIETransition(oTarget, nTransition, nDuration);

								oTarget.style.visibility = "hidden";
								oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Apply();
								oTarget.style.visibility = "visible";
								oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Play();
							}
							else
							{
								ProcessFFTranIn({ targetid: sTargetId, transtype: nTransition, transdur: nDuration });
							}
						}
					}
				}
			}
		}
		else
		{
			var oObject = GetObjectById(sTargetId);
			if (oObject != null)
			{
				var s = OpenObject(oObject, true);
				BoardAppendHTML(s);


					var sType = oObject.getAttribute("type");
					if (sType != null) CallMethod(sType, "Constructor", { pid: sTargetId });


				if (nTransition)
				{
					if (nTransition == 1)
					{
						nTransition = oObject.getAttribute("tranin");
						nDuration = oObject.getAttribute("durin");
					}
					else
					{
						nTransition -= 2;
						nDuration /= 1000;
					}

					if (nTransition != null && nDuration != null)
					{
						var nNow = 0;
						var oEFilters = null;
						try
						{
							oEFilters = oTarget.filters;
						}
						catch(e)
						{}
						if (((g_isMSIE && !g_isMSIE11) || (g_isMSIE11 && (nTransition==12 || nTransition==21 || nTransition==22))) && oEFilters!=null)
						{
							var oTarget = document.getElementById(sTargetId);
							AttachMSIETransition(oTarget, nTransition, nDuration);

							oTarget.style.visibility = "hidden";
							oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Apply();
							oTarget.style.visibility = "visible";
							oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Play();
						}
						else
						{
							ProcessFFTranIn({ targetid: sTargetId, transtype: nTransition, transdur: nDuration });
						}
					}
				}
			}
			else
			{
				var oGroup = g_oGroups.selectSingleNode("group[@id=\""+sTargetId+"\"]");
				if (oGroup != null)
				{
					var oRefs = oGroup.selectNodes("ref");
					for (var k = 0; k < oRefs.length; k++)
					{
						var oRef = oRefs[k];
						var sObjectId = oRef.getAttribute("id");
						ShowObject(sObjectId, nTransition, nDuration);
					}
				}
			}
		}

		var oObject = GetObjectById(sTargetId);
		if (oObject)
		{
			HandleEvt("EVENT_OBJECT_ONLOAD", null, sTargetId); /* Fire object's internal event handler, if any */
			var sOnLoad = oObject.getAttribute("onload");
			if (sOnLoad != null)
				processEvent(sOnLoad);

			var sSoundSrc = oObject.getAttribute("soundsrc");
			if (sSoundSrc != null)
			{
				var sPlay = oObject.getAttribute("play");
				if (sPlay == "1")
				{
					var sSoundId = oObject.getAttribute("id");
					PlaySound(sSoundSrc, sSoundId);
				}
			}
		}
	}
	catch (e)
	{
		alert("ShowObject:" + e.description);
	}
}
function HideObject(sTargetId, nTransition, nDuration)
{
	var oObject = GetObjectById(sTargetId);
	if (oObject)
	{
		var sTextId = oObject.getAttribute("textid");
		if (sTextId != null && sTextId != sTargetId)
		{
			HideObject(sTextId, nTransition, nDuration)
		}
	}

	try
	{
		var oTarget = document.getElementById(sTargetId);
		if (oTarget != null)
		{
			if (oTarget.style.display != "none")
			{
				if (g_bSoundOn == true && g_sSoundId != null)
				{
					if (g_sSoundId == sTargetId)
						StopSound();
				}

				if (nTransition)
				{
					if (nTransition == 1)
					{
						var oObject = GetObjectById(sTargetId);
						if (oObject)
						{
							nTransition = oObject.getAttribute("tranout");
							if (nTransition != null)
							{
								nTransition = oObject.getAttribute("tranout");
								nDuration = oObject.getAttribute("durout");
							}
						}
					}
					else
					{
						nTransition -= 2;
						nDuration /= 1000;
					}

					if (nTransition != null && nDuration != null)
					{
						var nNow = 0;
						var oEFilters = null;
						try
						{
							oEFilters = oTarget.filters;
						}
						catch(e)
						{}
						if (((g_isMSIE && !g_isMSIE11) || (g_isMSIE11 && (nTransition==12 || nTransition==21 || nTransition==22))) && oEFilters!=null)
						{
							AttachMSIETransition(oTarget, nTransition, nDuration);

							oTarget.style.visibility = "visible";
							oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Apply();
							oTarget.style.visibility = "hidden";
							oTarget.filters("DXImageTransform.Microsoft.RevealTrans").Play();

							CreateTimeActionDisplay(sTargetId, 1000 * parseFloat(nDuration), false, 0, 0);
						}
						else
						{
							ProcessFFTranOut( { targetid: sTargetId, transtype: nTransition, transdur: nDuration } );
						}
					}
					else
					{
						oTarget.style.display = "none";
					}
				}
				else
				{
					oTarget.style.display = "none";
				}
			}

			if (oObject)
			{
				var sOnComplete = oObject.getAttribute("oncomplete");
				if (sOnComplete != null)
					processEvent(sOnComplete);
			}
		}
		else
		{
			var oGroup = g_oGroups.selectSingleNode("group[@id=\""+sTargetId+"\"]");
			if (oGroup != null)
			{
				var oRefs = oGroup.selectNodes("ref");
				for (var k = 0; k < oRefs.length; k++)
				{
					var oRef = oRefs[k];
					var sObjectId = oRef.getAttribute("id");
					HideObject(sObjectId, nTransition, nDuration);
				}
			}
		}
	}
	catch (e)
	{
		alert("HideObject:" + e.description);
	}
}
function AttachFirefoxTranIn(sTargetId, nX, nY, nW, nH, nNow, nTransition, nDuration)
{
	try
	{
		var s = "";

		var sTransitionDivId = sTargetId + "_tranin";
		switch (nTransition)
		{
			case "12":
			{
				/* dissolve */
				CreateTimeActionAlpha(sTargetId, 0, 1000 * parseFloat(nDuration), 0, 100);
				break;
			}
			case "4":
			{
				/* down side up */
				s += "<div id=\""+ sTransitionDivId +"\"";
				s += " style=\"";
				s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ nW +"px;height:"+ nH +"px;";
				s += "background-color:#ffffff;z-index:200";
				s += "\">";
				s += "</div>";

				CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nW, nH, nW, 0);
				break;
			}
			case "5":
			{
				/* up side down */
				s += "<div id=\""+ sTransitionDivId +"\"";
				s += " style=\"";
				s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ nW +"px;height:"+ nH +"px;";
				s += "background-color:#ffffff;z-index:200";
				s += "\">";
				s += "</div>";

				CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nW, nH, nW, 0);
				CreateTimeActionMove(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nX, nY, nX, parseInt(nY) + parseInt(nH));
				break;
			}
			case "19":
			case "20":
			case "6":
			{
				/* left side right */
				s += "<div id=\""+ sTransitionDivId +"\"";
				s += " style=\"";
				s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ nW +"px;height:"+ nH +"px;";
				s += "background-color:#ffffff;z-index:200";
				s += "\">";
				s += "</div>";

				CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nW, nH, 0, nH);
				CreateTimeActionMove(sTransitionDivId, 0, 1000 * parseFloat(nDuration), parseInt(nX), nY, parseInt(nX) + parseInt(nW), nY);
				break;
			}
			case "7":
			{
				/* right side left */
				s += "<div id=\""+ sTransitionDivId +"\"";
				s += " style=\"";
				s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ nW +"px;height:"+ nH +"px;";
				s += "background-color:#ffffff;z-index:200";
				s += "\">";
				s += "</div>";

				CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nW, nH, 0, nH);
				break;
			}
			default:
			{
				/* up side down */
				s += "<div id=\""+ sTransitionDivId +"\"";
				s += " style=\"";
				s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ nW +"px;height:"+ nH +"px;";
				s += "background-color:#ffffff;z-index:200";
				s += "\">";
				s += "</div>";

				CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nW, nH, nW, 0);
				CreateTimeActionMove(sTransitionDivId, 0, 1000 * parseFloat(nDuration), nX, nY, nX, parseInt(nY) + parseInt(nH));
				break;
			}
		}

		if (nTransition != "12")
			CreateTimeActionDestroy(sTransitionDivId, 1000 * parseFloat(nDuration));
	}
	catch (e)
	{
		alert("AttachFirefoxTranIn: " + e + " " +
			sTargetId+" "+nX+" "+nY+" "+nW+" "+nH+" "+nNow+" "+nTransition+" "+nDuration);
	}

	return s;
}
function AttachFirefoxTranOut(sTargetId, nX, nY, nW, nH, nNow, nTransition, nDuration)
{
	var s = "";

	var sTransitionDivId = sTargetId +"_tranout";
	s += "<div id=\""+ sTransitionDivId +"\"";
	s += " style=\"";
	s += "position:absolute;left:"+	nX +"px;top:"+ nY +"px;width:"+ 0 +"px;height:"+ nH +"px;";
	s += "background-color:#ffffff;z-index:200";
	s += "\">";
	s += "</div>";

	CreateTimeActionDisplay(sTargetId, 1000 * parseFloat(nDuration), false, 0, 0);
	CreateTimeActionSize(sTransitionDivId, 0, 1000 * parseFloat(nDuration), 0, nH, nW, nH);
	CreateTimeActionDestroy(sTransitionDivId, 1000 * parseFloat(nDuration) + 100);

	return s;
}
function AttachMSIETransition(oTarget, nTransition, nDuration)
{
	var sFilter = "DXImageTransform.Microsoft.RevealTrans";
	var oFilter = null;
	var oTFilters = null;
	try
	{
		oTFilters = oTarget.filters;
	}
	catch(e)
	{}
	if(oTFilters!=null)
	{
		if (oTarget.filters.length != 0)
			if (oTarget.style.filter.indexOf(sFilter) != -1)
				oFilter = oTarget.filters.item(sFilter);

		if (oFilter == null)
		{
			oTarget.style.filter += " progid:"+sFilter+"(transition="+nTransition+",duration="+nDuration+")";
			oFilter = oTarget.filters.item(sFilter);
		}
	
		oFilter.Transition = nTransition;
		oFilter.Duration = parseFloat(nDuration);
	}
}
function BoardAppendHTML(s)
{
	if (g_isMSIE)
		g_oBoardFrame.insertAdjacentHTML("beforeEnd", s);
	else if (g_isFirefox)
		g_oBoardFrame.innerHTML += s;
}
function OpenFrame(oNewFrame, bKeepPreviousFrame)
{
	g_nFrameNum++;

	RemoveFrameThreads();

	{
		var dtBegin = new Date;
		g_nFrameBeginTime = dtBegin.valueOf();

		g_nSlideCurrentTime = g_nFrameBeginTime;
	}

	g_bPause = false;

	if (g_bSoundOn)
		StopSound();

	if (g_oSlideFrame != null)
		CloseFrame(g_oSlideFrame, bKeepPreviousFrame);

	g_oSlideFrame = oNewFrame;
	var dtBegin = new Date;

	g_nFrameBeginTime = dtBegin.valueOf();

	{
		g_nSlideCurrentTime = g_nFrameBeginTime;
		g_nSlideBeginTime = g_nFrameBeginTime;
		g_nSlideEndTime = g_nFrameBeginTime;

		var oFrames = g_oSlide.selectNodes("frames/frame");
		var nFrames = oFrames.length;

		for (var i = 0; i < nFrames; i++)
		{
			var oFrame = oFrames[i];
			var sDuration = oFrame.getAttribute("dur");
			if (sDuration != null)
				g_nSlideEndTime += parseInt(sDuration);
		}

		var oPreviousFrame = g_oSlideFrame;
		for (;;)
		{
			oPreviousFrame = oPreviousFrame.previousSibling;
			if (oPreviousFrame == null)
				break;
			if (oPreviousFrame.nodeType == 1 && oPreviousFrame.nodeName == "frame")
			{
				var sDuration = oPreviousFrame.getAttribute("dur");
				if (sDuration != null)
				{
					var nPreviousFrameDur = parseInt(sDuration);
					g_nSlideBeginTime -= nPreviousFrameDur;
					g_nSlideEndTime -= nPreviousFrameDur;
				}
			}
		}
	}

	var oOnLoad = g_oSlide.selectSingleNode("onload");
	if (oOnLoad != null)
		ProcessActions(oOnLoad);

	var oOnLoad = g_oSlideFrame.selectSingleNode("onload");
	if (oOnLoad != null)
		ProcessActions(oOnLoad);

	var sTotal = "";
	var oObjects = g_oSlideFrame.selectNodes("object");
	var nObjects = oObjects.length;

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];
		sTotal += OpenObject(oObject, false);
	}

	BoardAppendHTML(sTotal);

	CallConstructors(oObjects);

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];
		var nTransition = oObject.getAttribute("tranin");
		var sDisplay = oObject.getAttribute("display");
		var nBegin = oObject.getAttribute("begin");
		if (nTransition != null && nBegin == 0 && sDisplay != "none")
		{
			var sId = oObject.getAttribute("id");
			var oElement = document.getElementById(sId);
			var nDuration = oObject.getAttribute("durin");
			var oEFilters = null;
			try
			{
				oEFilters = oElement.filters;
			}
			catch(e)
			{}
			if (((g_isMSIE && !g_isMSIE11) || (g_isMSIE11 && (nTransition==12 || nTransition==21 || nTransition==22))) && oEFilters!=null)
			{
				AttachMSIETransition(oElement, nTransition, nDuration);
				var oStyle = oElement.style;
				var oFilter = oElement.filters("DXImageTransform.Microsoft.RevealTrans");
				oStyle.visibility = "hidden";
				oFilter.Apply();
				oStyle.visibility = "visible";
				oFilter.Play();
			}
			else
			{
				ProcessFFTranIn({ targetid: sId, transtype: nTransition, transdur: nDuration });
			}
		}
	}

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];

		var sDisplay = oObject.getAttribute("display");
		var nBegin = oObject.getAttribute("begin");

		if (!(sDisplay == "none" || nBegin != "0"))
		{
			var sOnLoad = oObject.getAttribute("onload");
			if (sOnLoad != null)
				processEvent(sOnLoad);
		}
	}

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];

		var sDisplay = oObject.getAttribute("display");
		var nBegin = oObject.getAttribute("begin");

		if (!(sDisplay == "none" || nBegin != "0"))
		{
			var sOnComplete = oObject.getAttribute("oncomplete");
			if (sOnComplete != null)
				processEvent(sOnComplete);
		}
	}

	var oTimeActions = g_oSlideFrame.selectNodes("timeline/timeaction");
	var nTimeActions = oTimeActions.length;

	for (var i = 0; i < nTimeActions; i++)
	{
		var oTimeAction = oTimeActions[i];

		var sType = oTimeAction.getAttribute("type");
		switch (sType)
		{
			case "display":
			{
				var nBegin = oTimeAction.getAttribute("begin");
				var sTargetId = oTimeAction.getAttribute("targetid");

				CreateTimeActionDisplay(sTargetId, nBegin, true, "1", "0");
				break;
			}
			case "hide":
			{
				var nBegin = oTimeAction.getAttribute("begin");
				var sTargetId = oTimeAction.getAttribute("targetid");

				var oDisplay = new Action;
				oDisplay.sType = "DISPLAY";
				oDisplay.sTargetId = sTargetId;
				oDisplay.sDisplay = "none";
				oDisplay.sTransition = "1";
				oDisplay.sDur = "0";
				oDisplay.nStartTime = 0;
				oDisplay.Continue = Action_ContinueDISPLAY;

				var oThread = new Thread;
				oThread.nFrameNum = g_nFrameNum;
				g_listThreads.Add(oThread);

				oThread.listActions.Add(oDisplay);
				InsertWaitAtThreadBegin(oThread, nBegin);
				break;
			}
			case "actionbox":
			{
				var nBegin = oTimeAction.getAttribute("begin");
				var sTargetId = oTimeAction.getAttribute("targetid");

				var oResponse = g_oSlideFrame.selectSingleNode("actionboxes/actionbox[@id='"+sTargetId+"']/RESPONSE[@name='"+sTargetId+"_1']");
				if (oResponse != null)
				{
					var oThread = new Thread;
					oThread.nFrameNum = g_nFrameNum;
					g_listThreads.Add(oThread);
					Thread_Load(oThread, oResponse.childNodes);
					InsertWaitAtThreadBegin(oThread, nBegin);
				}
				break;
			}
		}
	}

	var nFrameInfinite = g_oSlideFrame.getAttribute("infinite");
	if (nFrameInfinite == "0")
	{
		var nFrameDur = g_oSlideFrame.getAttribute("dur");

		var oGoto = new Action;
		oGoto.sType = "GOTO";
		oGoto.sOption = "1";
		oGoto.sFrameId = null;
		oGoto.nStartTime = 0;
		oGoto.bSystem = true;
		oGoto.Continue = Action_ContinueGOTO;

		var oThread = new Thread;
		oThread.nFrameNum = g_nFrameNum;
		g_listThreads.Add(oThread);

		oThread.listActions.Add(oGoto);
		InsertWaitAtThreadBegin(oThread, nFrameDur);
	}

	/* Create mouse pointers */
	var oMousePointers = g_oSlideFrame.selectSingleNode("mousepointers");
	if (oMousePointers != null)
	{
		var nStartX = oMousePointers.getAttribute("x");
		var nStartY = oMousePointers.getAttribute("y");
		var nTime = dtBegin.valueOf();

		var sPrevArrowFile = null;
		var sPrevArrowId = null;

		var sPrevClickFile = null;
		var sPrevClickId = null;

		var sArrowFile = null;
		var sArrowId = null;

		var sClickFile = null;
		var sClickId = null;

		var sDefArrowFile = "images/cursor_arrow.gif";
		var sDefArrowId = null;

		var sDefClickFile = "images/cursor_click.gif";
		var sDefClickId = null;

		oMousePointers = oMousePointers.selectNodes("mousepointer");
		var nMousePointers = oMousePointers.length;

		for (var i = 0; i < nMousePointers; i++)
		{
			var oMousePointer = oMousePointers[i];

			var nEndX = oMousePointer.getAttribute("x");
			var nEndY = oMousePointer.getAttribute("y");

			var nBegin = oMousePointer.getAttribute("begin");
			var nDur = oMousePointer.getAttribute("dur");
			var bClick = oMousePointer.getAttribute("click");

			sArrowFile = oMousePointer.getAttribute("arrowfile");
			if (sArrowFile == null)
			{
				if (sDefArrowId == null)
				{
					sDefArrowId ="IMG_ARROW";
					var s = "<img id=\""+sDefArrowId+"\" src=\"images/cursor_arrow.gif\" style=\"display:none;position:absolute;border-width:0;left:"+nStartX+"px;top:"+nStartY+"px;z-index:1000\"/>";
					BoardAppendHTML(s);
				}
				sArrowId = sDefArrowId;
				sArrowFile = sDefArrowFile;
			}
			else if (sArrowFile == sPrevArrowFile)
			{
				sArrowId = sPrevArrowId;
			}
			else
			{
				sArrowId = "IMG_ARROW" + i;
				var s = "<img id=\""+sArrowId+"\" src=\""+sArrowFile+"\" style=\"display:none;position:absolute;border-width:0;left:"+nStartX+"px;top:"+nStartY+"px;z-index:1000\"/>";
				BoardAppendHTML(s);
			}

			if (sArrowId != sPrevArrowId)
			{
				if (sPrevArrowId != null)
					CreateTimeActionDisplay(sPrevArrowId, nBegin, false, 0, 0);

				CreateTimeActionDisplay(sArrowId, nBegin, true, 0, 0);

				sPrevArrowFile = sArrowFile;
				sPrevArrowId = sArrowId;
			}

			nTime = parseInt(nBegin);

			CreateTimeActionMove(sArrowId, nBegin, nDur, nStartX, nStartY, nEndX, nEndY);

			nStartX = nEndX;
			nStartY = nEndY;
			nTime += parseInt(nDur);

			if (bClick != null)
			{
				sClickFile = oMousePointer.getAttribute("clickfile");
				if (sClickFile == null)
				{
					if (sDefClickId == null)
					{
						sDefClickId ="IMG_CLICK";
						var s = "<img id=\""+sDefClickId+"\" src=\"images/cursor_click.gif\" style=\"display:none;position:absolute;border-width:0;left:"+nStartX+"px;top:"+nStartY+"px;z-index:1000\"/>";
						BoardAppendHTML(s);
					}
					sClickId = sDefClickId;
					sClickFile = sDefClickFile;
				}
				else if (sClickFile == sPrevClickFile)
				{
					sClickId = sPrevClickId;
				}
				else
				{
					sClickId = "IMG_CLICK" + i;
					var s = "<img id=\""+sClickId+"\" src=\""+sClickFile+"\" style=\"display:none;position:absolute;border-width:0;left:"+nStartX+"px;top:"+nStartY+"px;z-index:1000\"/>";
					BoardAppendHTML(s);
				}

				CreateTimeActionMove(sClickId, nTime, nTime, nEndX, nEndY, nEndX, nEndY);

				nTime += 500;

				CreateTimeActionDisplay(sArrowId, nTime, false, 0, 0);

				CreateTimeActionDisplay(sClickId, nTime, true, 0, 0);

				nTime += 200;

				CreateTimeActionDisplay(sClickId, nTime, false, 0, 0);

				sPrevClickFile = sClickFile;
				sPrevClickId = sClickId;

				CreateTimeActionDisplay(sArrowId, nTime, true, 0, 0);
			}
		}
	}

	var sSoundSrc = null;
	var sSoundId = null;

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];

		var sDisplay = oObject.getAttribute("display");
		if (sDisplay != "none")
		{
			var nBegin = oObject.getAttribute("begin");
			if (nBegin == "0")
			{
				sSoundSrc = oObject.getAttribute("soundsrc");
				if (sSoundSrc != null)
				{
					var sPlay = oObject.getAttribute("play");
					if (sPlay == "1")
					{
						sSoundId = oObject.getAttribute("id");
						break;
					}
					sSoundSrc = null;
				}
			}
		}
	}
	if (sSoundSrc != null)
		PlaySound(sSoundSrc, sSoundId);

	if (g_listThreads.pFirst)
		g_nTimeoutId = setTimeout(TimerFunction2, GetResolution2());

	HandleEvt("EVENT_FRAME_OPENED", null);
}
function OpenMaster(oNewMaster)
{
	g_oMaster = oNewMaster;
	g_oMasterFrame = g_oMaster.selectSingleNode("frames/frame["+g_nFirst+"]");

	var sTotal = "";
	var oObjects = g_oMasterFrame.selectNodes("object");
	var nObjects = oObjects.length;

	for (var i = 0; i < nObjects; i++)
	{
		var oObject = oObjects[i];
		sTotal += OpenObject(oObject, false);
	}
	g_oBoardFrame.innerHTML = sTotal;

	CallConstructors(oObjects);
}
function OpenObject(oObject, bForceDisplay)
{
	var sId = oObject.getAttribute("id");
	var x = oObject.getAttribute("x");
	var y = oObject.getAttribute("y");
	var w = oObject.getAttribute("w");
	var h = oObject.getAttribute("h");
	var r = oObject.getAttribute("rotation");

	var nAlpha = oObject.getAttribute("alpha");
	var nTransition = oObject.getAttribute("tranin");
	var sDisplay = oObject.getAttribute("display");
	var nBegin = oObject.getAttribute("begin");
	var nZIndex = oObject.getAttribute("z");
	var nDraggable = oObject.getAttribute("draggable");
	var sNoDiv = oObject.getAttribute("nodiv");
	if (g_isFirefox)
	{
		sNoDiv = "no";

		var t;

		t = oObject.getAttribute("ffx");
		if (t != null)
			x = t;
		t = oObject.getAttribute("ffy");
		if (t != null)
			y = t;
		t = oObject.getAttribute("ffw");
		if (t != null)
			w = t;
		t = oObject.getAttribute("ffh");
		if (t != null)
			h = t;
	}

	var oDisplayObject = FindDisplayObject(sId);
	if (oDisplayObject == null)
		oDisplayObject = AddDisplayObject(sId, x, y, w, h, r, nZIndex);
	else
		SetDisplayObject(oDisplayObject, x, y, w, h, r, 0, 0, nZIndex);

	var oData = oObject.selectSingleNode("data");
	if (oData == null)
	{
		if (g_isMSIE)
		{
			if((oObject.getAttribute("preload")!=null && g_nVersion >= 7))
			{
				oData = oObject.selectSingleNode("ffdata");
			}
			else
			{
				oData = oObject.selectSingleNode("iedata");
			}
		}
		else
		{
			oData = oObject.selectSingleNode("ffdata");
		}
	}

	var sText = oData.text;

	for (;;)
	{
		var nPatternBegin = sText.indexOf("variable=\"");
		if (nPatternBegin == -1)
			break;
		var nNameBegin = nPatternBegin + 10;

		var nNameEnd = sText.indexOf("\"", nNameBegin);
		if (nNameEnd == -1)
			break;
		var nPatternEnd = nNameEnd + 1;

		var sName = sText.substr(nNameBegin, nNameEnd - nNameBegin);
		var sValue = IsSlideVar(sName) ? g_arSlideVars[sName] : g_arVars[sName];

		var sBefore = sText.substr(0, nPatternBegin);
		var sAfter = sText.substr(nPatternEnd);

		sText = sBefore + sValue + sAfter;
	}

	var s = "";

	if (sNoDiv != "yes")
	{
		s += "<div id=\""+ sId +"\"";
		s += " style=\"";

		var sFilters = "";

		if (r != null)
		{
			if (g_isMSIE)
			{
				var flRad = parseFloat(r) * (2 * Math.PI) / 360;
				var flCos = Math.cos(flRad);
				var flSin = Math.sin(flRad);

				var M11 = flCos;
				var M12 = -flSin;
				var M21 = flSin;
				var M22 = flCos;

				var flAbsSin = (flSin >= 0 ? flSin : -flSin);
				var flAbsCos = (flCos >= 0 ? flCos : -flCos);

				var cx = parseFloat(w) / 2;
				var cy = parseFloat(h) / 2;

				var offsetx = -cx*flAbsCos - cy*flAbsSin + cx;
				var offsety = -cx*flAbsSin - cy*flAbsCos + cy;

				x = parseFloat(x) + parseFloat(offsetx);
				y = parseFloat(y) + parseFloat(offsety);

				oDisplayObject.nRX = parseInt(x) - parseInt(oDisplayObject.nX);
				oDisplayObject.nRY = parseInt(y) - parseInt(oDisplayObject.nY);

				var sFilter = "DXImageTransform.Microsoft.Matrix";

				if (sFilters == "")
					sFilters = " filter:";
				sFilters += " progid:"+sFilter+"(sizingMethod='auto expand'";
				sFilters += ",M11="+M11+",M12="+M12+",M21="+M21+",M22="+M22;
				sFilters += ")";
			}
		}

		if (nAlpha != null)
		{
			if (sFilters == "")
				sFilters = " filter:";
			sFilters += " alpha(opacity="+ nAlpha +"); ";

			s += "-moz-opacity:."+ nAlpha +";";
			s += "opacity:."+ nAlpha +";";
		}

		s += "position:absolute;left:"+	x +"px;top:"+ y	+"px;width:"+ w	+"px;height:"+ h +"px;";
		s += "z-index:"+ nZIndex +";";
		s += sFilters;

		if ((sDisplay == "none" || nBegin != "0") && !bForceDisplay)
			s += "display:none;";
		else
		{
			if (g_isFirefox)
			{
				if (nTransition == "12")
					s += "opacity:0.0;";
			}
		}
		if (nDraggable != null)
			s += "-webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; cursor: move;";

		s += "\"";

		if (nDraggable != null)
		{
			if(g_oEnv.touch)
			{
				s += " ontouchstart=\"clTouch.Begin(this, event);\"";
				s += " ontouchend=\"clTouch.End(this, event);\"";
				s += " ontouchmove=\"clTouch.Move(this, event);\"";
				s += " ontouchcancel=\"clTouch.Cancel(this, event);\"";
			}
			else
			{
				s += ' onmousedown="clDrag.Begin(event)"';
			}
			s += ' draggable="1" -cl-draggable="1"';
		}
		s += ">";
	}
	else
	{
		var sStyles = "";
		sStyles += "position: absolute;";
		sStyles += "z-index: "+ nZIndex +";";

		if ((sDisplay == "none" || nBegin != "0") && !bForceDisplay)
			sStyles += "display: none;";

		var sPattern = /\[!STYLES\]/g;
		sText = sText.replace(sPattern, sStyles);

		var sAttrs = "";
		sAttrs += "id=\""+ sId +"\"";

		sPattern = /\[!ATTRS\]/g;
		sText = sText.replace(sPattern, sAttrs);
	}

	s += sText;

	if (sNoDiv != "yes")
	{
		s += "</div>";
	}

	return s;
}
function CreatePreloadingHTML()
{
	var oLoader = ReturnProgressObject();
	var s = "";
	if(oLoader!=null)
	{
		s += '<div id="DivLoadingImages" style="position:absolute; left: 0px; top: 0px; width: 100%; height: 100%; z-index:1000">';
		var sX = oLoader.getAttribute("x");
		var sY = oLoader.getAttribute("y");
		var sId = oLoader.getAttribute("id");
		var oParams = g_oParams.selectSingleNode("./param[@objectid='"+sId+"']");
		var bDisplay = (oParams.selectSingleNode("display_progress").text=="yes");
		var sData = oLoader.selectSingleNode("data").text;
		if(bDisplay) sData = ReplaceStr(sData, "display: none", "display: inline; position: absolute; top: " + sY + "px; left: " + sX + "px");
		s += sData;
		s += '</div>';
		return s;
	}
	s += "<div id=\""+ "DivLoadingImages" +"\"";
	s += " style=\"";
	s += "position:absolute;left:"+	0 +"px;top:"+ 0	+"px;width:100%;height:100%;";
	s += "z-index:1000";
	s += "\">";

	s += "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" height=\"100%\">";
	s += "<tr>";
	s += "<td valign=\"middle\" align=\"center\">";

	s += "<table cellpadding=\"0\" cellspacing=\"0\" width=\"300px\" height=\"125px\">";
	s += "<tr>";
	s += "<td valign=\"middle\" align=\"center\" bgcolor=\"#316ac5\">";

	s += "<table cellpadding=\"0\" cellspacing=\"0\" width=\"296px\" height=\"121px\">";
	s += "<tr>";
	s += "<td valign=\"middle\" align=\"center\" bgcolor=\"#f0f8ff\">";

	s += "<span id=\"SpanLoadingImages\" style=\"font-size:12px; color:#000000; font-family:arial\">";
	s += g_sLoadingImages+" <span id=\"LoadingPercent\"></span>...<br/>";
	s += "</span>";

	s += "</td>";
	s += "</tr>";

	s += "<tr>";
	s += "<td valign=\"middle\" align=\"center\" bgcolor=\"#f0f8ff\">";

	s += "<input type=\"button\" value=\""+g_sSkip+"\" style=\"font-size:12px; color:#000000; font-family:arial\" onclick=\"CancelPreload();\"/>";

	s += "</td>";
	s += "</tr>";
	s += "</table>";

	s += "</td>";
	s += "</tr>";
	s += "</table>";

	s += "</td>";
	s += "</tr>";
	s += "</table>";

	s += "</div>";

	return s;
}
function OpenSlide(oNewSlide, sFrameId, bPreloaded)
{
	
	var dtBegin = new Date;
	g_nFrameBeginTime = dtBegin.valueOf();

	g_nSlideCurrentTime = g_nFrameBeginTime;
	g_nSlideBeginTime = g_nFrameBeginTime;
	g_nSlideEndTime = g_nFrameBeginTime;

	g_oSlide = oNewSlide;
	document.title = g_oSlide.getAttribute("name");

	if (g_bPreloadImages && g_isMSIE && bPreloaded == undefined)
	{
		if (g_oSlideFrame != null)
		{
			CloseFrame(g_oSlideFrame, false);
			g_oSlideFrame = null;
		}
		else
			g_oBoardFrame.innerHTML = "";

		g_sSlideFrameId = sFrameId;

		var s = CreatePreloadingHTML();
		BoardAppendHTML(s);

		setTimeout(PreloadImages, 0);
		return;
	}

	g_arSlideVars = new Array();

	try
	{
		SCOAddSlideToVisits(oNewSlide);

		var sSlideId = "";
		if (g_oSlide != null)
			sSlideId = g_oSlide.getAttribute("id");

		SCOApplyRules();

		g_sLmsCmiLocation = sSlideId;
		g_sLmsCmiExit = "suspend";

		LMSSaveState();
	}
	catch (e)
	{
	}

	var dtCurrent = new Date();
	g_nSlideBeginTime = dtCurrent.valueOf();
	g_nSlideCurrentTime = g_nSlideBeginTime;
	g_nSlideEndTime = g_nSlideBeginTime;

	var sMasterId = g_oSlide.getAttribute("masterid");

	var bMasterChanged = true;
	if (g_oMaster != null)
	{
		if (g_oMaster.getAttribute("id") ==	sMasterId)
			bMasterChanged = false;
	}

	if (bMasterChanged == true)
	{
		var oNewMaster = g_oMasters.selectSingleNode("slide[@id='"+sMasterId+"']");
		OpenMaster(oNewMaster);
	}

	var oNewFrame = g_oSlide.selectSingleNode(sFrameId == null ? "frames/frame["+g_nFirst+"]" : "frames/frame[@id='"+sFrameId+"']");

	var oFrames = g_oSlide.selectNodes("frames/frame");
	var nFrames = oFrames.length;

	for (var i = 0; i < nFrames; i++)
	{
		var oFrame = oFrames[i];
		var sDuration = oFrame.getAttribute("dur");
		if (sDuration != null)
			g_nSlideEndTime += parseInt(sDuration);
	}

	OpenFrame(oNewFrame, false);

	HandleEvt("EVENT_SLIDE_OPENED", null);

	var oOnComplete = g_oSlide.selectSingleNode("oncomplete");
	if (oOnComplete != null)
		ProcessActions(oOnComplete);

	if (g_oSlideFrame != null)
	{
		var sDuration = g_oSlideFrame.getAttribute("dur");
		if (sDuration == "0")
		{
			var oNextFrame = g_oSlideFrame.nextSibling;
			while (oNextFrame != null && oNextFrame.nodeType != 1)
				oNextFrame = oNextFrame.nextSibling;

			if (oNextFrame == null)
				HandleEvt("EVENT_SLIDE_COMPLETE", null);
		}
	}
}
function OpenSlideById(sSlideId)
{
	var oNewSlide = g_oSlides.selectSingleNode("slide[@id=\""+sSlideId+"\"]");
	if (oNewSlide != null)
		OpenSlide(oNewSlide, null);
}
function CloseFrame(oFrame, bKeepPreviousFrame)
{

	var oNextFrame = g_oSlideFrame.nextSibling;
	while (oNextFrame != null && oNextFrame.nodeType != 1)
		oNextFrame = oNextFrame.nextSibling;

	var oMasterObjects = null;
	if (g_oMasterFrame != null)
		oMasterObjects = g_oMasterFrame.selectNodes("object");

	var oElements = g_oBoardFrame.childNodes;
	for (var i = oElements.length - 1; i >= 0; i--)
	{
		var oElement = oElements[i];
		if (oElement.nodeType == 1)
		{
			var sElementId = oElement.getAttribute("id");

			var bMaster = false;
			if (oMasterObjects != null)
			{
				for (var j = oMasterObjects.length - 1; j >= 0; j--)
				{
					var oObject = oMasterObjects[j];
					if (oObject.getAttribute("id") == sElementId)
					{
						bMaster = true;
						break;
					}
				}
			}

			if (!bMaster)
			{
				var bRemove = true;

				var bSVGRedirect = (oElement.getAttribute("svg")!=null);
				if(bSVGRedirect)
				{
					var oRedirector = oElement;
					oElement = document.getElementById(oRedirector.getAttribute("svg"));
					if(oElement==null)
					{
						oElement = oRedirector;
						bSVGRedirect = false;
					}
				}

				if (bKeepPreviousFrame)
				{
					if (oNextFrame != null)
					{
						var oObject = g_oSlide.selectSingleNode("frames/frame/object[@id='"+ sElementId +"']");
						if (oObject)
						{
							var sDisplay = oObject.getAttribute("display");
							if (sDisplay == "slide")
								bRemove = false;
						}
					}
				}

				if (bRemove)
				{
					var sDestructor = oElement.getAttribute("destructor");
					if (sDestructor != null)
					{
						var oObject = GetObjectById(sElementId);
						if (oObject != null)
						{
							var sType = oObject.getAttribute("type");
							if (sType != null)
							{
								var oArgs = new Object;
								oArgs.pid = sElementId;
								CallMethod(sType, sDestructor, oArgs);
							}
						}
					}

					if(bSVGRedirect)
					{
						document.body.removeChild(oElement);
						oElement = null;
						g_oBoardFrame.removeChild(oRedirector);
						oRedirector = null;
					}
					else
					{
						g_oBoardFrame.removeChild(oElement);
						oElement = null;
					}

					var oDisplayObject = FindDisplayObject(sElementId);
					if (oDisplayObject != null)
						g_listDisplayObjects.Subtract(oDisplayObject);

					for (var oEvtHandler = g_listEvtHandlers.pFirst; oEvtHandler != null; )
					{
						var pNext = oEvtHandler.pNext;

						if (oEvtHandler.sTargetId == sElementId)
							g_listEvtHandlers.Subtract(oEvtHandler);

						oEvtHandler = pNext;
					}
				}
			}
		}
	}
}
function CloseObject(sTargetId)
{
	var oTarget = document.getElementById(sTargetId);
	if (oTarget)
	{
		oTarget.style.display = "none";

		if (g_bSoundOn == true && g_sSoundId != null)
			if (g_sSoundId == sTargetId)
				StopSound();
	}
}
function NextFrame(bFromAction)
{
	if (g_oSlideFrame == null)
		return;

	try
	{
		var oNextFrame = g_oSlideFrame.nextSibling;
		while (oNextFrame != null && oNextFrame.nodeType != 1)
			oNextFrame = oNextFrame.nextSibling;

		if (oNextFrame != null)
		{
			var dtCurrent = new Date();
			g_nSlideCurrentTime = dtCurrent.valueOf();

			var nCurrentFrameElapsed = parseInt(g_nSlideCurrentTime - g_nFrameBeginTime);
			var nCurrentFrameDur = parseInt(g_oSlideFrame.getAttribute("dur"));

			g_nSlideBeginTime -= (nCurrentFrameDur - nCurrentFrameElapsed);
			g_nSlideCurrentTime -= (nCurrentFrameDur - nCurrentFrameElapsed);
			g_nSlideEndTime -= (nCurrentFrameDur - nCurrentFrameElapsed);

			OpenFrame(oNextFrame, true);
		}
		else
		{
			HandleEvt("EVENT_SLIDE_COMPLETE", null);

			var sAdvance = g_oSlide.getAttribute("advance");
			if (sAdvance == "immediate" || bFromAction==true)
				NextSlide();
		}
	}
	catch (e)
	{
		alert("NextFrame:" + e.description);
	}
}
function NextSlide()
{
	try
	{
		var oNextSlide = g_oSlide.nextSibling;
		while (oNextSlide != null && oNextSlide.nodeType != 1)
			oNextSlide = oNextSlide.nextSibling;
		if (oNextSlide != null)
			OpenSlide(oNextSlide, null);
	}
	catch (e)
	{
		alert("NextSlide:" + e.description);
	}
}
function PreviousFrame()
{
	try
	{
		var oPreviousFrame = g_oSlideFrame.previousSibling;
		while (oPreviousFrame != null && oPreviousFrame.nodeType != 1)
			oPreviousFrame = oPreviousFrame.previousSibling;

		if (oPreviousFrame != null)
		{
			var dtCurrent = new Date();
			g_nSlideCurrentTime = dtCurrent.valueOf();

			var nCurrentFrameElapsed = parseInt(g_nSlideCurrentTime - g_nFrameBeginTime);
			var nPreviousFrameDur = parseInt(oPreviousFrame.getAttribute("dur"));

			g_nSlideBeginTime += (nPreviousFrameDur + nCurrentFrameElapsed);
			g_nSlideCurrentTime += (nPreviousFrameDur + nCurrentFrameElapsed);
			g_nSlideEndTime += (nPreviousFrameDur + nCurrentFrameElapsed);

			OpenFrame(oPreviousFrame, false);
		}
	}
	catch (e)
	{
		alert("PreviousFrame:" + e.description);
	}
}
function PreviousSlide()
{
	try
	{
		var oPreviousSlide = g_oSlide.previousSibling;
		while (oPreviousSlide != null && oPreviousSlide.nodeType != 1)
			oPreviousSlide = oPreviousSlide.previousSibling;
		if (oPreviousSlide != null)
			OpenSlide(oPreviousSlide, null);
	}
	catch (e)
	{
		alert("PreviousSlide:" + e.description);
	}
}
function GatherImages(oSlide)
{
	var oDiv = document.createElement("div");

	var oFrames = oSlide.selectNodes("frames/frame");
	var nFrames = oFrames.length;

	for (var j = 0; j < nFrames; j++)
	{
		var oFrame = oFrames[j];
		var oObjects = oFrame.selectNodes("object");
		var nObjects = oObjects.length;

		for (var k = 0; k < nObjects; k++)
		{
			var oObject = oObjects[k];

			var sPreload = oObject.getAttribute("preload");
			if (sPreload != null)
			{
				var bFound = false;
				for (var m = 0; m < g_nImages; m++)
					if (g_oImages[m].src == sPreload)
					{
						bFound = true;
						break;
					}
				if (bFound != true)
				{
					var nImage = g_nImages;
					g_nImages++;
					g_oImages[nImage] = new Image();
					g_oImages[nImage].onreadystatechange = ImageOnReadyStateChange;
					g_oImages[nImage].src = sPreload;
}
				continue;
			}

			var oData = oObject.selectSingleNode("data");
			if (oData == null)
			{
				if (g_isMSIE)
				{
					if(oObject.getAttribute("preload")!=null && g_nVersion >= 7) 
					{
						oData = oObject.selectSingleNode("ffdata");
					}
					else
					{
						oData = oObject.selectSingleNode("iedata");
					}
				}
				else
				{
					oData = oObject.selectSingleNode("ffdata");
				}
			}

			var sText = oData.text;

			oDiv.innerHTML = sText;

			var oImages = oDiv.getElementsByTagName("img");
			var nDivImages = oImages.length;
			for (var l = 0; l < nDivImages; l++)
			{
				var oImage = oImages[l];
				var sSrc = oImage.src;
				if (sSrc != "")
				{
					var bFound = false;
					for (var m = 0; m < g_nImages; m++)
						if (g_oImages[m].src == sSrc)
						{
							bFound = true;
							break;
						}
					if (bFound != true)
					{
						var nImage = g_nImages;
						g_nImages++;
						g_oImages[nImage] = new Image();
						g_oImages[nImage].onreadystatechange = ImageOnReadyStateChange;
						g_oImages[nImage].src = sSrc;
					}
				}
			}

			var oTds = oDiv.getElementsByTagName("td");
			var nTds = oTds.length;
			for (var l = 0; l < nTds; l++)
			{
				var oTd = oTds[l];
				var sBackground = oTd.background;
				if (sBackground != "")
				{
					var bFound = false;
					for (var m = 0; m < g_nImages; m++)
						if (g_oImages[m].src == sBackground)
						{
							bFound = true;
							break;
						}
					if (bFound != true)
					{
						var nImage = g_nImages;
						g_nImages++;
						g_oImages[nImage] = new Image();
						g_oImages[nImage].src = sBackground;
						g_oImages[nImage].onreadystatechange = ImageOnReadyStateChange;
					}
				}
			}
		}
	}
}
function ImageOnReadyStateChange()
{
	if (g_bPreloadingImages)
	{
		var nTotalImages = g_oImages.length;
		var nImagesLoaded = nTotalImages;

		var bAllLoaded = true;
		for (var i = nTotalImages - 1; i >= 0; i--)
		{
			if (g_oImages[i].readyState != "complete")
			{
				nImagesLoaded--;
				bAllLoaded = false;
			}
		}

		if (nTotalImages != 0)
		{
			var oSpan = document.getElementById("LoadingPercent");
			if (oSpan != null)
			{
				var flRatio = parseInt(nImagesLoaded) / parseInt(nTotalImages);
				var nPercent = parseInt(parseFloat(flRatio) * 100);
				var s = nPercent + "%";
				oSpan.innerText = s;
				var oBar = document.getElementById("CL_progress_bar");
				if(oBar!=null)
				{
					var oBarLeft = document.getElementById("CL_progress_left");
					var oBarRight = document.getElementById("CL_progress_right");
					if(oBarLeft!=null && oBarRight!=null)
					{
						var nRight = 100 - nPercent;
						oBarLeft.style.width = nPercent.toString() + "%";
						oBarRight.style.width = nRight.toString() + "%";
					}
				}
			}
		}

		if (bAllLoaded == true)
		{
			g_bPreloadingImages = false;

			var oDiv = document.getElementById("DivLoadingImages");
			if (oDiv != null)
				oDiv.parentNode.removeChild(oDiv);

			OpenSlide(g_oSlide, g_sSlideFrameId, true);
		}
	}
}
function PreloadImages()
{
	g_bPreloadingImages = false;

	g_oImages = new Array();
	g_nImages = 0;

	var sMasterId = g_oSlide.getAttribute("masterid");
	var bMasterChanged = true;
	if (g_oMaster != null)
	{
		if (g_oMaster.getAttribute("id") ==	sMasterId)
			bMasterChanged = false;
	}
	if (bMasterChanged)
	{
		var oNewMaster = g_oMasters.selectSingleNode("slide[@id='"+sMasterId+"']");
		if (oNewMaster)
			GatherImages(oNewMaster);
	}
	GatherImages(g_oSlide);

	if (g_nImages > 0)
	{
		g_bPreloadingImages = true;
		setTimeout(ImageOnReadyStateChange, 10);
	}
	else
	{
		g_bPreloadingImages = false;

		var oDiv = document.getElementById("DivLoadingImages");
		if (oDiv != null)
			oDiv.parentNode.removeChild(oDiv);

		OpenSlide(g_oSlide, g_sSlideFrameId, true);
	}
}
function CancelPreload()
{

	g_bPreloadingImages = false;

	var oDiv = document.getElementById("DivLoadingImages");
	if (oDiv != null)
		oDiv.parentNode.removeChild(oDiv);

	OpenSlide(g_oSlide, g_sSlideFrameId, true);
}
function DragBegin(oElement, oEvent)
{
	g_bDragOn = true; 
	if (g_isMSIE)
	{
		oElement.setCapture(true);
	}
	else
	{
		oEvent.preventDefault();
		if (window.Event)
		{
			window.captureEvents(Event.MOUSEMOVE);
			window.captureEvents(Event.MOUSEOVER);
			window.captureEvents(Event.MOUSEOUT);
		}
	}
	g_nOffsetX = oEvent.clientX - parseInt(oElement.style.left);
	g_nOffsetY = oEvent.clientY - parseInt(oElement.style.top);
	return true;
}
function DragEnd(oElement, oEvent)
{
	if (g_bDragOn)
	{
		g_bDragOn = false;

		g_oDragObject = oElement;
		if (g_isMSIE)
		{
			oElement.releaseCapture();
		}
		else
		{
			if (window.Event)
			{
				window.releaseEvents(Event.MOUSEMOVE);
				window.releaseEvents(Event.MOUSEOVER);
				window.releaseEvents(Event.MOUSEOUT);
			}
		}

		GetDropTarget(oEvent.clientX, oEvent.clientY, oElement.id);

		var sDragObjectId = g_oDragObject.getAttribute("id");

		var oDisplayObject = FindDisplayObject(sDragObjectId);
		if (oDisplayObject)
	    {
			oDisplayObject.nX = g_oDragObject.offsetLeft - oDisplayObject.nRX;
			oDisplayObject.nY = g_oDragObject.offsetTop - oDisplayObject.nRY;
	    }

		HandleEvt("EVENT_DRAG_END", null);

		if (g_oDragTarget != null)
		{
			var sTargetId = g_oDragTarget.getAttribute("id");
			var oTarget = g_oSlides.selectSingleNode("slide/frames/frame/object[@id='"+sTargetId+"']");
			if (oTarget)
			{
				var sResponseId = oTarget.getAttribute("ondrop");
				if (sResponseId != null)
				{
					processEvent(sResponseId);
				}
			}
		}

		g_oDragObject = null;
		g_oDragTarget = null;
		g_oDHTMLDragTarget = null;
	}
}
function DragMove(oElement, oEvent)
{
	if (g_bDragOn)
	{
		oElement.style.left = oEvent.clientX - g_nOffsetX;
		oElement.style.top = oEvent.clientY - g_nOffsetY;
	}
}
function GetDropTarget(x, y, id)
{
	var oChildren = g_oBoardFrame.childNodes;
	for (var i = oChildren.length - 1; i >= 0; i--)
	{
		var oChild = oChildren[i];
		if (oChild.id != id)
		{
			var oStyle = oChild.style;
			if (oStyle.display != "none")
			{
				if (parseInt(oStyle.left) <= x && parseInt(oStyle.left) + parseInt(oStyle.width) > x &&
					parseInt(oStyle.top) <= y && parseInt(oStyle.top) + parseInt(oStyle.height) > y)
				{
					g_oDragTarget = oChild;
					g_oDHTMLDragTarget = GetChildOfDropTarget(g_oDragTarget, x, y, id);

					return;
				}
			}
		}
	}
}
function GetChildOfDropTarget(oParent, x, y, id)
{
	var oElement = oParent;

	var oChildren = oParent.childNodes;
	for (var i = oChildren.length - 1; i >= 0; i--)
	{
		var oChild = oChildren[i];
		if (oChild.id != id)
		{
			var oStyle = oChild.style;
			if ((oStyle == undefined) ||
				(oStyle != undefined && oStyle.display != "none"))
			{
				var offsetTop = oChild.offsetTop;
				var offsetParent = oChild.offsetParent;
				while (offsetParent != null)
				{
					offsetTop += offsetParent.offsetTop;
					offsetParent = offsetParent.offsetParent;
				}

				var offsetLeft = oChild.offsetLeft;
				offsetParent = oChild.offsetParent;
				while (offsetParent != null)
				{
					offsetLeft += offsetParent.offsetLeft;
					offsetParent = offsetParent.offsetParent;
				}

				if (parseInt(offsetLeft) <= x && parseInt(offsetLeft) + parseInt(oChild.offsetWidth) > x &&
					parseInt(offsetTop) <= y && parseInt(offsetTop) + parseInt(oChild.offsetHeight) > y)
				{
					oElement = GetChildOfDropTarget(oChild, x, y, id);
					break;
				}
			}
		}
	}
	return oElement;
}
function PlaySound(sSoundSrc, sSoundId)
{
	if (g_bSoundEnabled)
	{
		g_bSoundOn = true;
		g_sSoundId = sSoundId;
		if (sSoundSrc.indexOf('.swf') != -1)
			SWPlaySound(sSoundSrc);
		else
			WMPlaySound(sSoundSrc);
	}
}
function StopSound()
{
	if (g_bSoundOn)
	{
		g_bSoundOn = false;
		g_sSoundId = null;
		WMStopSound();
		SWStopSound();
	}
}
function EnableSound(bEnable)
{
	if (bEnable)
	{
		g_bSoundEnabled = true;
	}
	else
	{
		g_bSoundEnabled = false;
		StopSound();
	}
}

var CLM =
{
	oSupports: {},
	GetMIME: function (oArgs)
	{
		var sContainer = "";
		var sMIMEType  ="";
		switch(oArgs.ext)
		{
			case "wav":
			{
				sContainer = "audio";
				sMIMEType = "audio/wav";
				break;
			}
			case "mp3":
			{
				sContainer = "audio";
				sMIMEType = "audio/mpeg";
				break;
			}
			case "mp4":
			{
				sContainer = "video";
				sMIMEType = "video/mp4";
				break;
			}
			case "ogg":
			{
				if(oArgs.type!=null)
				{
					if(oArgs.type=="audio")
					{
						sContainer = "audio";
						sMIMEType = "audio/ogg";
					}
					else
					{
						sContainer = "video";
						sMIMEType = "video/ogg";
					}
				}
				else
				{
					sContainer = "video";
					sMIMEType = "video/ogg";
				}
				break;
			}
			case "webm":
			{
				sContainer = "video";
				sMIMEType = "video/webm";
				break;
			}
		}
		return { container: sContainer, mime: sMIMEType };
	},
	Supports: function (oArgs)
	{
		/* container: audio/video, mime: full mimetype */
		if(oArgs.container=="") return false;
		var oElem = document.createElement(oArgs.container);
		var bSupports = false;
		if(typeof oElem.canPlayType == "function")
		{
			var sPlayable = oElem.canPlayType(oArgs.mime);
			bSupports = ((sPlayable.toLowerCase()=="maybe") || (sPlayable.toLowerCase()=="probably"));
		}
		return bSupports;		
	}
};
function WMPlaySound(sSoundSrc)
{
	var sExtension = sSoundSrc.substr( sSoundSrc.lastIndexOf(".") + 1 );
	var oExtInfo = CLM.GetMIME({ ext: sExtension, type: "audio"  });
	var bAudioSupported = CLM.Supports(oExtInfo);
	if(!bAudioSupported && (g_oEnv.browser.isOpera || g_oEnv.browser.isFF))
	{
		bAudioSupported = CLM.Supports(CLM.GetMIME({ ext: "ogg", type: "audio"  }));
		if(bAudioSupported)
		{
			sSoundSrc = sSoundSrc.substring(0, sSoundSrc.lastIndexOf(".")) + ".ogg";
		}
	}
	if(bAudioSupported)
	{
		if(g_oAudioPlayer==null)
		{
			g_oAudioPlayer = document.createElement("audio");
			g_oAudioPlayer.setAttribute("id", "cl-audio-player");
			g_oAudioPlayer.setAttribute("controls", "controls");
			g_oAudioPlayer.setAttribute("autoplay", "autoplay");
			g_oAudioPlayer.style.position = "absolute";
			g_oAudioPlayer.style.left = "-2000px";
			g_oAudioPlayer.style.top = "-2000px";
			g_oAudioPlayer.style.visibility = "hidden";
			g_oAudioPlayer.style.zIndex = 12000;
			document.body.appendChild(g_oAudioPlayer);
			
		}
		try
		{
			g_oAudioPlayer.setAttribute("src", sSoundSrc);
			g_oAudioPlayer.play();
			g_bWMSoundOn = true;
		}
		catch(e)
		{}
	}
	else
	{
		if(g_oAudioPlayer==null)
		{
			g_oAudioPlayer = document.getElementById("WMPlayer");
			try
			{
				if(!g_isOpera) InsertWMPlayer();
				g_oAudioPlayer = document.getElementById("WMPlayer");
			}
			catch(e)
			{}
		}
		if(g_oAudioPlayer!=null)
		{
			try
			{
				if(window.location.protocol.toLowerCase().indexOf("http")==0)
				{
					var sURL = window.location.protocol + "//" + window.location.host + window.location.pathname;
					sURL = sURL.substring(0, sURL.lastIndexOf("/"));
					sSoundSrc = sURL + "/" + sSoundSrc;
				}
				g_oAudioPlayer.URL = sSoundSrc;
				g_oAudioPlayer.controls.play();
				g_bWMSoundOn = true;
			}
			catch(e)
			{}
		}
	}
}
function WMStopSound()
{
	if (g_bWMSoundOn)
	{
		g_bWMSoundOn = false;
		if(g_oAudioPlayer!=null)
		{
			if(g_oAudioPlayer.nodeName.toLowerCase()=="audio")
			{
				try
				{
					g_oAudioPlayer.pause();
				}
				catch(e)
				{}
			}
			else
			{
				try
				{
					g_oAudioPlayer.controls.stop();
				}
				catch(e)
				{}
			}
		}
		if(g_oAudioPlayerInt!=null)
		{
			if(g_oAudioPlayerInt.nodeName.toLowerCase()=="audio")
			{
				try
				{
					g_oAudioPlayerInt.pause();
				}
				catch(e)
				{}
			}
			else
			{
				try
				{
					g_oAudioPlayerInt.controls.stop();
				}
				catch(e)
				{}
			}
		}
	}
}
function SWPlaySound(sSoundSrc)
{
	try
	{
		var oPlayer = document.getElementById("SWPlayer");
		if(oPlayer==null)
		{
			try
			{
				InsertSWPlayer();
			}
			catch(e)
			{}
			oPlayer = document.getElementById("SWPlayer");
		}
		else
		{
			if(g_isMSIE)
			{
				oPlayer.LoadMovie(0, g_sCourseImages + "dummy.swf");
			}
			else
			{
				oPlayer.parentNode.removeChild(oPlayer);
				oPlayer = null;
				try
				{
					InsertSWPlayer();
				}
				catch(e)
				{}
				oPlayer = document.getElementById("SWPlayer");
			}
		}
		if(oPlayer != null)
		{
			g_bSWSoundOn = true;
			if(g_isOpera)
			{
				oPlayer.setAttribute("src", sSoundSrc);
			}
			else
			{
				if(g_isFirefox) oPlayer.setAttribute("src", sSoundSrc);
				oPlayer.LoadMovie(0, sSoundSrc);
			}
			try
			{
				oPlayer.Play();
			}
			catch(x)
			{
				/* Opera workaround */
			}
		}
	}
	catch(e)
	{}
}
function SWStopSound()
{
	if (g_bSWSoundOn)
	{
		g_bSWSoundOn = false;
		try
		{
			var oPlayer = document.getElementById("SWPlayer");
			if (oPlayer != null)
			{
				oPlayer.Rewind();
				oPlayer.StopPlay();
				if(g_isMSIE)
				{
					oPlayer.LoadMovie(0, g_sCourseImages + "dummy.swf");
				}
				if(g_isOpera) oPlayer.setAttribute("src", "");
			}
		}
		catch(e)
		{}
	}
}
function PlaySoundInternal(sSoundSrc)
{
	if (g_bSoundEnabled)
	{
		if (sSoundSrc.indexOf('.swf') != -1)
		{
			var oInternalPlayer = document.getElementById("SWPlayerInternal");
			if(oInternalPlayer==null)
			{
				try
				{
					InsertSWPlayerInternal();
				}
				catch(e)
				{}
				oInternalPlayer = document.getElementById("SWPlayerInternal");
			}
			else
			{
				if(g_isMSIE)
				{
					oInternalPlayer.LoadMovie(0, g_sCourseImages + "dummy.swf");
				}
				else
				{
					oInternalPlayer.parentNode.removeChild(oInternalPlayer);
					oInternalPlayer = null;
					InsertSWPlayerInternal();
					oInternalPlayer = document.getElementById("SWPlayerInternal");
				}
			}
			if (oInternalPlayer != null)
			{
				try
				{
					if(g_isOpera)
					{
						oInternalPlayer.setAttribute("src", sSoundSrc);
					}
					else
					{
						if(g_isFirefox) oInternalPlayer.setAttribute("src", sSoundSrc);
						oInternalPlayer.LoadMovie(0, sSoundSrc);
					}
					try
					{
						oInternalPlayer.Play();
					}
					catch(x)
					{
						if(g_isOpera) oInternalPlayer.Stop();/* Opera workaround */
					}
				}
				catch(e)
				{}
			}
		}
		else
		{
			var sExtension = sSoundSrc.substr( sSoundSrc.lastIndexOf(".") + 1 );
			var oExtInfo = CLM.GetMIME({ ext: sExtension, type: "audio"  });
			var bAudioSupported = CLM.Supports(oExtInfo);
			if(!bAudioSupported && (g_oEnv.browser.isOpera || g_oEnv.browser.isFF))
			{
				bAudioSupported = CLM.Supports(CLM.GetMIME({ ext: "ogg", type: "audio"  }));
				if(bAudioSupported)
				{
					sSoundSrc = sSoundSrc.substring(0, sSoundSrc.lastIndexOf(".")) + ".ogg";
				}
			}
			if(bAudioSupported)
			{
				if(g_oAudioPlayerInt==null)
				{
					g_oAudioPlayerInt = document.createElement("audio");
					g_oAudioPlayerInt.setAttribute("id", "cl-audio-player-int");
					g_oAudioPlayerInt.setAttribute("controls", "controls");
					g_oAudioPlayerInt.setAttribute("autoplay", "autoplay");
					g_oAudioPlayerInt.style.position = "absolute";
					g_oAudioPlayerInt.style.left = "-2000px";
					g_oAudioPlayerInt.style.top = "-2000px";
					g_oAudioPlayerInt.style.visibility = "hidden";
					g_oAudioPlayerInt.style.zIndex = 12001;
					document.body.appendChild(g_oAudioPlayerInt);
				}
				try
				{
					g_oAudioPlayerInt.setAttribute("src", sSoundSrc);
					g_oAudioPlayerInt.play();
				}
				catch(e)
				{}
			}
			else
			{
				g_oAudioPlayerInt = document.getElementById("WMPlayerInternal");
				if(g_oAudioPlayerInt == null)
				{
					if(!g_isOpera) InsertWMPlayerInternal();
					g_oAudioPlayerInt = document.getElementById("WMPlayerInternal");
				}
				if(g_oAudioPlayerInt != null)
				{
					g_oAudioPlayerInt.controls.stop();
					if(window.location.protocol.toLowerCase().indexOf("http")==0)
					{
						var sURL = window.location.protocol + "//" + window.location.host + window.location.pathname;
						sURL = sURL.substring(0, sURL.lastIndexOf("/"));
						sSoundSrc = sURL + "/" + sSoundSrc;
					}
					g_oAudioPlayerInt.URL = sSoundSrc;
					g_oAudioPlayerInt.controls.play();
				}
			}
		}
	}
}
function InsertWMPlayerInternal()
{
	if (g_isMSIE || g_isOpera)
	{
		var oPlayer = document.createElement("object");
		oPlayer.setAttribute("id", "WMPlayerInternal");
		oPlayer.setAttribute("classid", "clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6");
		oPlayer.setAttribute("width", "1");
		oPlayer.setAttribute("height", "1");
		g_oBoardFrame.appendChild(oPlayer);
		var oParam = document.createElement("param");
		oParam.setAttribute("name", "uiMode");
		oParam.setAttribute("value", "invisible");
		oPlayer.appendChild(oParam);
	}
	else
	{
		var oPlayer = document.createElement("embed");
		oPlayer.setAttribute("id", "WMPlayerInternal");
		oPlayer.setAttribute("name", "WMPlayerInternal");
		oPlayer.setAttribute("type", "application/x-mplayer2");
		oPlayer.setAttribute("width", "0");
		oPlayer.setAttribute("height", "0");
		oPlayer.setAttribute("autostart", "0");
		oPlayer.setAttribute("loop", "0");
		var oDiv = document.createElement("div");
		oDiv.appendChild(oPlayer);
		g_oBoardFrame.appendChild(oDiv);
		oDiv.style.display = "none";
	}
}
function InsertWMPlayer()
{
	if (g_isMSIE || g_isOpera)
	{
		var s = "";
		s += "<object id=\"WMPlayer\" classid=\"clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6\" width=\"0\" height=\"0\">";
		s += "<param name=\"uiMode\" value=\"none\" />";
		s += "</object>";

		g_oBoardFrame.insertAdjacentHTML("afterEnd", s);
	}
	else
	{
		var s = "<embed";
		s += " id=\"WMPlayer\"";
		s += " name=\"WMPlayer\"";
		s += " type=\"application/x-mplayer2\"";
		s += " width=\"0\"";
		s += " height=\"0\"";
		s += " AutoStart=\"0\"";
		s += " loop=\"0\">";
		s += "</embed>";
						   
		var oDiv = document.createElement("div");
		oDiv.innerHTML = s;
		g_oBoardFrame.appendChild(oDiv);
	}
}
function InsertSWPlayerInternal()
{
	var sProtocol = "http:";
	try
	{
		if(window.location.protocol=="https:") sProtocol = "https:";
	}
	catch(e)
	{}
	if (g_isMSIE)
	{
		var oPlayer = document.createElement("object");
		oPlayer.setAttribute("id", "SWPlayerInternal");
		oPlayer.setAttribute("classid", "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000");
		oPlayer.setAttribute("width", "1");
		oPlayer.setAttribute("height", "1");
		oPlayer.setAttribute("codebase", sProtocol + "//download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0");
		var oDiv = document.createElement("div");
		oDiv.appendChild(oPlayer);
		g_oBoardFrame.appendChild(oDiv);
		var oParam = document.createElement("param");
		oParam.setAttribute("name", "swliveconnect");
		oParam.setAttribute("value", "true");
		oPlayer.appendChild(oParam);
		oParam = document.createElement("param");
		oParam.setAttribute("name", "AllowScriptAccess");
		oParam.setAttribute("value", "always");
		oPlayer.appendChild(oParam);
	}
	else
	{
		var oPlayer = document.createElement("embed");
		oPlayer.setAttribute("id", "SWPlayerInternal");
		oPlayer.setAttribute("name", "SWPlayerInternal");
		oPlayer.setAttribute("type", "application/x-shockwave-flash");
		oPlayer.setAttribute("width", "0");
		oPlayer.setAttribute("height", "0");
		oPlayer.setAttribute("swliveconnect", "1");
		oPlayer.setAttribute("AllowScriptAccess", "always");
		oPlayer.setAttribute("quality", "high");
		var oDiv = document.createElement("div");
		oDiv.appendChild(oPlayer);
		g_oBoardFrame.appendChild(oDiv);
	}
}
function InsertSWPlayer()
{
	var sProtocol = "http:";
	try
	{
		if(window.location.protocol=="https:") sProtocol = "https:";
	}
	catch(e)
	{}
	if (g_isMSIE)
	{
		var s = "";
		s += "<object";
		s += " id=\"SWPlayer\"";
		s += " width=\"0\"";
		s += " height=\"0\"";
		s += " classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"";
		s += " codebase=\"" + sProtocol + "//download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0\"";
		s += ">";
		s += "</object>";

		g_oBoardFrame.insertAdjacentHTML("afterEnd", s);
	}
	else
	{
		var s = "<embed";
		s += " id=\"SWPlayer\"";
		s += " name=\"SWPlayer\"";
		s += " type=\"application/x-shockwave-flash\"";
		s += " width=\"0\"";
		s += " height=\"0\"";
		s += " swliveconnect=\"1\"";
		s += " quality=\"high\">";
		s += "</embed>";

		var oDiv = document.createElement("div");
		oDiv.innerHTML = s;
		g_oBoardFrame.appendChild(oDiv);
	}
}
function ReplaceMacrosInStr(sString)
{
	var reLeft = new RegExp(/\{\{/);
	var reRight = new RegExp(/\}\}/);
	var sResult = sString;
	if(reLeft.test(sString) && reRight.test(sString))
	{
		var iStart = 0;
		var iEnd = 0;
		var iTmp = 0;
		var sBuffer = sString;
		var sTestStr = "";
		sResult = "";
		while(reLeft.test(sBuffer))
		{
			iStart = sBuffer.search(reLeft);
			if(iStart>0)
			{
				sResult += sBuffer.substring(0,iStart);
				sBuffer = sBuffer.substr(iStart);
				iStart = 0;
			}
			iEnd = sBuffer.search(reRight);
			if(iEnd==-1)
			{
				sResult += "{{";
				sBuffer = sBuffer.substr(2);
				continue;
			}
			sTestStr = sBuffer.substring(iStart+2,iEnd);
			sValue = ReplacePropertiesInStr(sTestStr);
			if(sValue!=sTestStr)
			{
				sResult += sValue;
				sBuffer = sBuffer.substr(iEnd+2);
				continue;
			}
			sValue = ReplaceVariablesInStr(sTestStr);
			if(sValue!=sTestStr)
			{
				sResult += sValue;
				sBuffer = sBuffer.substr(iEnd+2);
				continue;
			}
			sResult += "{{" + sTestStr + "}}";
			sBuffer = sBuffer.substr(iEnd+2);
		}
		sResult += sBuffer;
	}
	return sResult;
}
function ReplaceVariablesInStr(sString, bEval)
{
	if(bEval==null) var bEval = false;
	var reLeft = new RegExp(/\#/);
	var sResult = sString;
	if(reLeft.test(sString))
	{
		var reRight = new RegExp(/\W/);
		var sBuffer = sString;
		var sTestStr = "";
		var sValue = "";
		var iStart = 0;
		var iEnd = 0;
		var bSlideVar = false;
		sResult = "";
		while(reLeft.test(sBuffer))
		{
			iStart = sBuffer.search(reLeft);
			if(iStart>0)
			{
				sResult += sBuffer.substring(0,iStart);
				sBuffer = sBuffer.substr(iStart);
				iStart = 0;
			}
			sBuffer = sBuffer.substr(1);
			iEnd = sBuffer.search(reRight);
			sTestStr = iEnd==-1 ? sTestStr = sBuffer.substr(iStart) : sBuffer.substring(iStart,iEnd);
			bSlideVar = IsSlideVar(sTestStr);
			sValue = bSlideVar ? g_arSlideVars[sTestStr] : g_arVars[sTestStr];
			if(sValue==null)
			{
				sResult = sResult + "#" + sTestStr;
			}
			else
			{
				if(bEval)
				{
					if(typeof sValue == "number")
					{
						sResult += sValue;
					}
					else
					{
						if(typeof sValue == "string")
						{
							sResult += "\""+sValue+"\"";
						}
						else
						{
							sResult = sResult + "#" + sTestStr;
						}
					}
				}
				else
				{
					sResult += sValue;
				}
			}
			sBuffer = iEnd==-1 ? "" : sBuffer.substr(iEnd);
		}
		sResult += sBuffer;
	}
	return sResult;
}
function ReplacePropertiesInStr(sString, bEval)
{
	if(bEval==null) var bEval = false;
	var reObjPtr = new RegExp(/\$/);
	if(!reObjPtr.test(sString)) return sString;
	var sBuffer = sString;
	var reObjEnd = new RegExp(/\./);
	var rePropEnd = new RegExp(/\W/);
	var iObjStart = 0;
	var iObjEnd = 0;
	var iPropEnd = 0;
	var iTmp = 0;
	var sValue = "";
	var sObjectId = "";
	var sPropertyName = "";
	var sPropertyValue = "";
	while(reObjPtr.test(sBuffer))
	{
		iObjStart = sBuffer.search(reObjPtr);
		if(iObjStart>0)
		{
			sValue += sBuffer.substring(0,iObjStart);
			sBuffer = sBuffer.substr(iObjStart);
			iObjStart = 0;
		}
		iObjEnd = sBuffer.search(reObjEnd);
		if(iObjEnd==-1)
		{
			sValue += "$";
			sBuffer = sBuffer.substr(1);
			continue;
		}
		sObjectId = sBuffer.substring(iObjStart+1,iObjEnd);
		if(GetObjectById(sObjectId)==null)
		{
			sValue += "$"+sObjectId+".";
			sBuffer = sBuffer.substr(iObjEnd+1);
			continue;
		}
		iTmp = sBuffer.substr(iObjEnd+1).search(rePropEnd);
		iPropEnd = iTmp + iObjEnd + 1;
		sProperty = iTmp==-1 ? sBuffer.substr(iObjEnd+1) : sBuffer.substring(iObjEnd+1,iPropEnd);
		sPropertyValue = GetObjectProperty(sObjectId, sProperty);
		if(sPropertyValue==null)
		{
			sValue = iTmp==-1 ? sValue + sBuffer : sValue + sBuffer.substring(0,iPropEnd);
		}
		else
		{
			if(bEval)
			{
				if(typeof sPropertyValue=="number")
				{
					sValue += sPropertyValue.toString();
				}
				else
				{
					if(typeof sPropertyValue=="string")
					{
						sValue += "\""+sPropertyValue+"\"";
					}
					else
					{
						sValue = iTmp==-1 ? sValue + sBuffer : sValue + sBuffer.substring(0,iPropEnd);
					}
				}
			}
			else
			{
				if(typeof sPropertyValue=="string" || typeof sPropertyValue=="number")
				{
					sValue += sPropertyValue.toString();
				}
				else
				{
					sValue = iTmp==-1 ? sValue + sBuffer : sValue + sBuffer.substring(0,iPropEnd);
				}
			}
		}
		sBuffer = iTmp==-1 ? "" : sBuffer.substr(iPropEnd);
	}
	if (sBuffer!="") sValue += sBuffer;
	return sValue;
}
function GetObjectProperty(sObjectId, sProperty)
{
	if (sObjectId == null || sProperty == null)
		return null;

	var sValue = null;

	switch (sProperty)
	{
		case "x":
			var oDisplayObject = FindDisplayObject(sObjectId);
			if (oDisplayObject)
				sValue = oDisplayObject.nX;
			break;
		case "y":
			var oDisplayObject = FindDisplayObject(sObjectId);
			if (oDisplayObject)
				sValue = oDisplayObject.nY;
			break;
		case "w":
			var oDisplayObject = FindDisplayObject(sObjectId);
			if (oDisplayObject)
				sValue = oDisplayObject.nW;
			break;
		case "h":
			var oDisplayObject = FindDisplayObject(sObjectId);
			if (oDisplayObject)
				sValue = oDisplayObject.nH;
			break;
		case "z":
			var oDisplayObject = FindDisplayObject(sObjectId);
			if (oDisplayObject)
				sValue = oDisplayObject.nZ;
			break;
		case "startx":
			var oObject = GetObjectById(sObjectId);
			if (oObject != null)
				sValue = oObject.getAttribute("x");
			break;
		case "starty":
			var oObject = GetObjectById(sObjectId);
			if (oObject != null)
				sValue = oObject.getAttribute("y");
			break;
		case "startw":
			var oObject = GetObjectById(sObjectId);
			if (oObject != null)
				sValue = oObject.getAttribute("w");
			break;
		case "starth":
			var oObject = GetObjectById(sObjectId);
			if (oObject != null)
				sValue = oObject.getAttribute("h");
			break;
		case "startz":
			var oObject = GetObjectById(sObjectId);
			if (oObject != null)
				sValue = oObject.getAttribute("z");
			break;
	}

	if (sValue == null)
	{
		var oObject = GetObjectById(sObjectId);
		if (oObject != null)
		{
			sValue = oObject.getAttribute(sProperty);
			if (sValue == null)
			{
				var sType = oObject.getAttribute("type");
				if (sType != null)
				{
					var oArgs = new Object;
					oArgs.pid = sObjectId;
					oArgs.property = sProperty;
					CallMethod(sType, "GetProperty", oArgs);
					sValue = g_vPropertyValue;
					g_vPropertyValue = null;
				}
			}
		}
	}
	return sValue;
}
function CreateSCO()
{
	oDoc = CreateDOMDocument();

	var oSCO = oDoc.createElement("SCO");
	if (g_isMSIE)
		oDoc.appendChild(oSCO);
	else if (g_isFirefox)
		oDoc.documentElement.appendChild(oSCO);

	var oVisits = oDoc.createElement("visits");
	oSCO.appendChild(oVisits);

	var oObjects = oDoc.createElement("objects");
	oSCO.appendChild(oObjects);

	var oObjectives = oDoc.createElement("objectives");
	oSCO.appendChild(oObjectives);

	var oInteractions = oDoc.createElement("interactions");
	oSCO.appendChild(oInteractions);

	var oModuleObjectives = g_oModule.selectSingleNode("objectives");
	if (oModuleObjectives != null)
	{
		oModuleObjectives = oModuleObjectives.selectNodes("objective");
		var nModuleObjectives = oModuleObjectives.length;

		for (var i = 0; i < nModuleObjectives; i++)
		{
			var oModuleObjective = oModuleObjectives[i];

			var oObjective = oDoc.createElement("o");
			oObjectives.appendChild(oObjective);

			var s;
			s = oModuleObjective.getAttribute("id");
			oObjective.setAttribute("id", s);

			s = oModuleObjective.getAttribute("name");
			oObjective.setAttribute("desc", s);

			s = oModuleObjective.getAttribute("module");
			if (s == "yes")
				oObjective.setAttribute("module", "yes");

			s = oModuleObjective.getAttribute("cs");
			if (s == null)
				s = "n";
			oObjective.setAttribute("cs", s);

			s = oModuleObjective.getAttribute("ss");
			if (s == null)
				s = "u";
			oObjective.setAttribute("ss", s);

			s = oModuleObjective.getAttribute("scoremax");
			oObjective.setAttribute("max", s);

			s = oModuleObjective.getAttribute("scoremin");
			oObjective.setAttribute("min", s);

			oObjective.setAttribute("raw", "0");
			oObjective.setAttribute("scaled", "0");
		}
	}

	g_oDocSCO = oDoc;
	g_oSCO = oSCO;
}
function SCOAddSlideToVisits(oSlide)
{
	var bVisited = SCOIsSlideVisited(oSlide);
	if (bVisited == false)
	{
		var oVisits = g_oSCO.selectSingleNode("visits");

		var sSid = oSlide.getAttribute("sid");
		while (sSid.length < 2)
			sSid = "0" + sSid;

		if (g_isFirefox)
		{
			var sText = "";
			var oText = oVisits.childNodes[0];
			if (oText != null)
			{
				sText = oText.nodeValue;
			}
			else
			{
				oText = document.createTextNode(sSid);
				oVisits.appendChild(oText);
			}
			sText += sSid;
			oText.nodeValue = sText;
		}
		else if (g_isMSIE)
		{
			var sText = oVisits.text;
			sText += sSid;
			oVisits.text = sText;
		}
	}
}
function SCOIsSlideVisited(oSlide)
{
	var sSid = oSlide.getAttribute("sid");
	while (sSid.length < 2)
		sSid = "0" + sSid;

	var oVisits = g_oSCO.selectSingleNode("visits");

	var sText = "";
	if (g_isFirefox)
	{
		var oText = oVisits.childNodes[0];
		if (oText != null)
			sText = oText.nodeValue;
	}
	else if (g_isMSIE)
	{
		sText = oVisits.text;
	}

	var bVisited = false;

	var nTextLen = sText.length;
	for (var i = 0; i < nTextLen; i += 2)
	{
		var s = sText.substr(i, 2);
		if (s == sSid)
		{
			bVisited = true;
			break;
		}
	}

	return bVisited;
}
function SetObjectiveCompletionStatus(sObjectiveId, sStatus)
{
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
	{
		if (oObjective.getAttribute("cs") != sStatus)
		{
			oObjective.setAttribute("cs", sStatus);
			SCOApplyRules();
		}
	}
}
function GetObjectiveCompletionStatus(sObjectiveId)
{
	var s = "";
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
		s = oObjective.getAttribute("cs");
	return s;
}
function SetObjectiveSuccessStatus(sObjectiveId, sStatus)
{
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
	{
		if (oObjective.getAttribute("ss") != sStatus)
		{
			oObjective.setAttribute("ss", sStatus);
			SCOApplyRules();
		}
	}
}
function GetObjectiveSuccessStatus(sObjectiveId)
{
	var s = "";
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
		s = oObjective.getAttribute("ss");
	return s;
}
function SetObjectiveScore(sObjectiveId, sSourceId, sAdditive, sScore)
{
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
	{
		SCOSetSourceScore(oObjective, sSourceId, sAdditive, sScore);

		SCORollupObjectiveScore(oObjective);
		SCOUpdateObjectiveScaled(oObjective);
		SCOApplyObjectiveRules(oObjective);
	}
}
function GetObjectiveSourceScore(sObjectiveId, sSourceId)
{
	var sScore = "";
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
	{
		var oSource = oObjective.selectSingleNode("s[@id='"+ sSourceId +"']");
		if (oSource != null)
			sScore = oSource.getAttribute("raw");
	}
	return sScore;
}
function GetObjectiveScore(sObjectiveId)
{
	var sScore = "";
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	if (oObjective != null)
		sScore = oObjective.getAttribute("raw");
	return sScore;
}
function GetObjective(sObjectiveId)
{
	var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjectiveId +"']");
	return oObjective;
}
function GetInteraction(sInteractionId)
{
	var oInteraction = g_oSCO.selectSingleNode("interactions/i[@id='"+ sInteractionId +"']");
	return oInteraction;
}
function SCOSetSourceScore(oObjective, sSourceId, sAdditive, sScore)
{
	var bCreated = false;
	var oSource = oObjective.selectSingleNode("s[@id='"+ sSourceId +"']");
	if (oSource == null)
	{
		oSource = g_oDocSCO.createElement("s");
		oObjective.appendChild(oSource);
		oSource.setAttribute("id", sSourceId);
		oSource.setAttribute("raw", "0");
		bCreated = true;
	}

	switch (sAdditive)
	{
		case "sum":
			var sOldScore = oSource.getAttribute("raw");
			var sNewScore = parseFloat(sOldScore) + parseFloat(sScore);
			oSource.setAttribute("raw", sNewScore);
			break;
		case "replace":
			oSource.setAttribute("raw", sScore);
			break;
	}

	return bCreated;
}
function SCOCheckCondition(oCondition)
{
	var bSuccess = false;
	try
	{
		var sType = oCondition.getAttribute("type");
		switch (sType)
		{
			case "group":
			{
				var oChildConditions = oCondition.selectNodes("condition");
				var nChildConditions = oChildConditions.length;

				for (var i = 0; i < nChildConditions; i++)
				{
					var oChildCondition = oChildConditions[i];
					var bChildSuccess = SCOCheckCondition(oChildCondition);

					if (i == 0)
						bSuccess = bChildSuccess;
					else
					{
						var sOp = oChildCondition.getAttribute("op");
						switch (sOp)
						{
							case "and":
								bSuccess = bSuccess && bChildSuccess;
								break;
							case "or":
								bSuccess = bSuccess || bChildSuccess;
								break;
							case "andnot":
								bSuccess = bSuccess && !bChildSuccess;
								break;
							case "ornot":
								bSuccess = bSuccess || !bChildSuccess;
								break;
						}
					}
				}
				break;
			}

			case "visited":
			{
				var sConditionVisits = oCondition.getAttribute("visits");

				var nConditionVisitsLen = sConditionVisits.length;
				if (nConditionVisitsLen > 0)
				{
					var sSCOVisits = "";
					var oVisits = g_oSCO.selectSingleNode("visits");
					if (g_isFirefox)
					{
						var oText = oVisits.childNodes[0];
						if (oText != null)
							sSCOVisits = oText.nodeValue;
					}
					else if (g_isMSIE)
					{
						sSCOVisits = oVisits.text;
					}

					var nSCOVisitsLen = sSCOVisits.length;

					var bAllVisited = true;
					for (var i = 0; i < nConditionVisitsLen; i += 2)
					{
						var sConditionVisit = sConditionVisits.substr(i, 2);
						var bVisited = false;
						for (var j = 0; j < nSCOVisitsLen; j += 2)
						{
							var sSCOVisit = sSCOVisits.substr(j, 2);
							if (sSCOVisit == sConditionVisit)
							{
								bVisited = true;
								break;
							}
						}
						if (!bVisited)
						{
							bAllVisited = false;
							break;
						}
					}
					if (bAllVisited)
						bSuccess = true;
				}
				break;
			}

			case "score":
			{
				var sObjective = oCondition.getAttribute("objective");
				var sComp = oCondition.getAttribute("comp");
				var sScore = oCondition.getAttribute("score");

				var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjective +"']");
				if (oObjective != null)
				{
					var sObjectiveRaw = oObjective.getAttribute("raw");
					switch (sComp)
					{
						case "lt":
							if (parseFloat(sObjectiveRaw) < parseFloat(sScore))
								bSuccess = true;
							break;
						case "gt":
							if (parseFloat(sObjectiveRaw) > parseFloat(sScore))
								bSuccess = true;
							break;
						case "eq":
							if (parseFloat(sObjectiveRaw) == parseFloat(sScore))
								bSuccess = true;
							break;
						case "le":
							if (parseFloat(sObjectiveRaw) <= parseFloat(sScore))
								bSuccess = true;
							break;
						case "ge":
							if (parseFloat(sObjectiveRaw) >= parseFloat(sScore))
								bSuccess = true;
							break;
						case "ne":
							if (parseFloat(sObjectiveRaw) != parseFloat(sScore))
								bSuccess = true;
							break;
					}
				}
				break;
			}

			case "success":
			{
				var sObjective = oCondition.getAttribute("objective");
				var sSS = oCondition.getAttribute("ss");

				var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjective +"']");
				if (oObjective != null)
				{
					var sObjectiveSS = oObjective.getAttribute("ss");
					if (sSS == sObjectiveSS)
						bSuccess = true;
				}
				break;
			}

			case "completion":
			{
				var sObjective = oCondition.getAttribute("objective");
				var sCS = oCondition.getAttribute("cs");

				var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjective +"']");
				if (oObjective != null)
				{
					var sObjectiveCS = oObjective.getAttribute("cs");
					if (sCS == sObjectiveCS)
						bSuccess = true;
				}
				break;
			}
		}
	}
	catch (e)
	{
		alert("SCOCheckCondition: " + e.description);
	}
	return bSuccess;
}
function SCOApplyRules()
{
	try
	{
		if (g_oModule!=null)
		{
			var oRules = g_oModule.selectNodes("rules/rule");
			var nRules = oRules.length;

			for (var i = 0; i < nRules; i++)
			{
				var oRule = oRules[i];
				var sObjective = oRule.getAttribute("objective");

				var oObjective = g_oSCO.selectSingleNode("objectives/o[@id='"+ sObjective +"']");
				if (oObjective != null)
				{
					var sSS = oRule.getAttribute("ss");
					var sCS = oRule.getAttribute("cs");

					var bCheck = false;
					if (sSS != null)
					{
						if (oObjective.getAttribute("ss") != sSS)
							bCheck = true;
					}
					if (sCS != null)
					{
						if (oObjective.getAttribute("cs") != sCS)
							bCheck = true;
					}

					if (bCheck)
					{
						var bSuccess = false;

						var oChildConditions = oRule.selectNodes("condition");
						var nChildConditions = oChildConditions.length;

						for (var j = 0; j < nChildConditions; j++)
						{
							var oChildCondition = oChildConditions[j];
							var bChildSuccess = SCOCheckCondition(oChildCondition);

							if (j == 0)
								bSuccess = bChildSuccess;
							else
							{
								var sOp = oChildCondition.getAttribute("op");
								switch (sOp)
								{
									case "and":
										bSuccess = bSuccess && bChildSuccess;
										break;
									case "or":
										bSuccess = bSuccess || bChildSuccess;
										break;
									case "andnot":
										bSuccess = bSuccess && !bChildSuccess;
										break;
									case "ornot":
										bSuccess = bSuccess || !bChildSuccess;
										break;
								}
							}
						}

						if (bSuccess == true)
						{
							if (sSS != null)
								oObjective.setAttribute("ss", sSS);
							if (sCS != null)
								oObjective.setAttribute("cs", sCS);
						}
					}
				}
			}
		}
	}
	catch (e)
	{
		alert("SCOApplyRules: " + e.description);
	}
}
function SCOApplyObjectiveRules(oObjective)
{
	SCOApplyRules();
}
function SCORollupSCOScore()
{
	var oObjectives = g_oSCO.selectNodes("objectives/o");
	var nObjectives = oObjectives.length;

	for (var i = 0; i < nObjectives; i++)
	{
		var oObjective = oObjectives[i];
		SCORollupObjectiveScore(oObjective);
		SCOUpdateObjectiveScaled(oObjective);
	}
}
function SCORollupObjectiveScore(oObjective)
{
	var nObjectiveRaw = 0;

	var oSources = oObjective.selectNodes("s");
	var nSources = oSources.length;

	for (var i = 0; i < nSources; i++)
	{
		var oSource = oSources[i];

		var sSourceRaw = oSource.getAttribute("raw");
		nObjectiveRaw = nObjectiveRaw + parseFloat(sSourceRaw);
	}

	oObjective.setAttribute("raw", nObjectiveRaw);
}
function SCOUpdateObjectiveScaled(oObjective)
{
	var sMax = oObjective.getAttribute("max");
	var sMin = oObjective.getAttribute("min");
	var sRaw = oObjective.getAttribute("raw");

	var sScaled = "0";
	if ((parseFloat(sMax) - parseFloat(sMin)) != 0)
	{
		sScaled = (parseFloat(sRaw) - parseFloat(sMin)) / (parseFloat(sMax) - parseFloat(sMin));
	}
	sScaled = FormatReal_10_7(sScaled);
	oObjective.setAttribute("scaled", sScaled);
}
function SCOSetObjectProp(sObjectId, sName, sValue)
{
	var oObjects = g_oSCO.selectSingleNode("objects");

	var bCreated = false;
	var oObject = oObjects.selectSingleNode("o[@id='"+ sObjectId +"']");
	if (oObject == null)
	{
		oObject = g_oDocSCO.createElement("o");
		oObjects.appendChild(oObject);
		oObject.setAttribute("id", sObjectId);
		bCreated = true;
	}

	oObject.setAttribute(sName, sValue);
	return bCreated;
}
function SCOGetObjectProp(sObjectId, sName)
{
	var sValue = null;

	var oObjects = g_oSCO.selectSingleNode("objects");
	var oObject = oObjects.selectSingleNode("o[@id='"+ sObjectId +"']");
	if (oObject)
		sValue = oObject.getAttribute(sName);

	return sValue;
}
function SCOSetInteraction(sInteractionId, sInteractionType, arObjectives, arCorrectResponses, sWeighting, sLearnerResponse, sResult, sDescription, bJournaling)
{
	var oInteractions = g_oSCO.selectSingleNode("interactions");
	if (oInteractions == null)
	{
		oInteractions = g_oDocSCO.createElement("interactions");
		g_oSCO.appendChild(oInteractions);
	}

	if (!bJournaling)
	{
		for (;;)
		{
			var oInteraction = oInteractions.selectSingleNode("i[@id='"+ sInteractionId +"']");
			if (oInteraction == null)
				break;
			oInteraction.parentNode.removeChild(oInteraction);
		}
	}

	var oInteraction = g_oDocSCO.createElement("i");
	oInteractions.appendChild(oInteraction);
	oInteraction.setAttribute("id", sInteractionId);
	oInteraction.setAttribute("t", sInteractionType);

	var oObjectives = g_oDocSCO.createElement("oo");
	oInteraction.appendChild(oObjectives);
	for (var i = 0; i < arObjectives.length; i++)
	{
		var sObjectiveId = arObjectives[i];

		var oObjective = g_oDocSCO.createElement("o");
		oObjectives.appendChild(oObjective);

		oObjective.setAttribute("id", sObjectiveId);
	}

	var oCorrectResponses = g_oDocSCO.createElement("rr");
	oInteraction.appendChild(oCorrectResponses);
	for (var i = 0; i < arCorrectResponses.length; i++)
	{
		var sCorrectResponse = arCorrectResponses[i];

		var oCorrectResponse = g_oDocSCO.createElement("r");
		oCorrectResponses.appendChild(oCorrectResponse);

		oCorrectResponse.setAttribute("p", sCorrectResponse);
	}

	oInteraction.setAttribute("w", sWeighting);

	oInteraction.setAttribute("l", sLearnerResponse);

	oInteraction.setAttribute("r", sResult);

	oInteraction.setAttribute("d", sDescription);
}
function DocumentOnKeyDown(oEvent)
{
	if (g_bPause == false)
	{
	    if (g_oSlideFrame)
		{
			var sOnKeyDown = g_oSlideFrame.getAttribute("onkeydown");
			if (sOnKeyDown)
				processEventKeyStr(oEvent, g_oSlideFrame, sOnKeyDown);
		}

		if (g_oSlide)
		{
			var sOnKeyDown = g_oSlide.getAttribute("onkeydown");
			if (sOnKeyDown)
				processEventKeyStr(oEvent, g_oSlide, sOnKeyDown);
		}
	}
	return true;
}
function DocumentOnKeyUp()
{
	return true;
}
function Run(bPreloadImages)
{
	if (typeof window.document.addEventListener == 'function')
	{
		window.document.addEventListener('oncopy', function(e) { return false; }, false);
	}
	else if (typeof window.event == 'object')
	{
		var oBody = window.document.body;
		oBody.ondragstart = function() { return false; };
		oBody.oncopy = function() { return false; };
		oBody.ondrag = function() { return false; };
		oBody = null;
	}

	g_oBoardFrame = document.getElementById("boardFrame");
	g_bPreloadImages = true;

	CheckBrowserType();
	SetEnvironmentVars();

	if(!g_isMSIE)
	{
		UpdateFirefoxDOM();
	}
	else
	{
		DetermineMSXMLProgID();
		DetermineMSXMLHTTPProgID();
	}

	LMSInitialize();

	var sSlideId = null;
	var sFrameId = null;
	if (typeof(oHTA) != "undefined")
	{
		var sCmdLine = oHTA.commandLine;
		if (sCmdLine)
		{
			if (sCmdLine.indexOf("slideid") != -1)
			{
				var s = sCmdLine.substr(sCmdLine.indexOf("slideid") + 8);
				sSlideId = s.substring(s.indexOf('"', 0) + 1, s.indexOf('"', 1));

				if (sCmdLine.indexOf("frameid") != -1)
				{
					var s = sCmdLine.substr(sCmdLine.indexOf("frameid") + 8);
					sFrameId = s.substring(s.indexOf('"', 0) + 1, s.indexOf('"', 1));
				}
			}
		}
	}

	if (typeof window.document.addEventListener == 'function')
		window.document.addEventListener('keydown', function(e) { /*alert(e.keyCode);*/ DocumentOnKeyDown(e) }, false);
	else if (typeof window.event == 'object')
		window.document.onkeydown=function() { /*alert(window.event.keyCode);*/ DocumentOnKeyDown(window.event) }

	if (typeof window.document.addEventListener == 'function')
		window.document.addEventListener('keyup', function(e) { /*alert(e.keyCode);*/ DocumentOnKeyUp(e) }, false);
	else if (typeof window.event == 'object')
		window.document.onkeyup=function() { /*alert(window.event.keyCode);*/ DocumentOnKeyUp(window.event) }

	if (sSlideId == null)
	{
		var bShowSplash = LoadSplash();
		if (bShowSplash == false)
			StartModule(sSlideId, sFrameId);
	}
	else
		StartModule(sSlideId, sFrameId);
}
function LoadSplash()
{
	var oDoc = CreateDOMDocument();
	var bLoaded = false;
	if (g_isMSIE)
	{
		oDoc.async = false;
		bLoaded = oDoc.load("splash.xml");
	}
	else if (g_isFirefox)
	{
		var sWindowLocation = window.location;
		sWindowLocation = sWindowLocation.toString();
		sWindowLocation = sWindowLocation.toLowerCase()
		if(sWindowLocation.indexOf("http:")!=-1 || sWindowLocation.indexOf("https:")!=-1)
		{
			var oRequest = new XMLHttpRequest();
			oRequest.open('GET', 'splash.xml', false);
			oRequest.send(null);
			if (oRequest.status == 200)
			{
				var sResponseText = oRequest.responseText;

				var objDOMParser = new DOMParser();
				var objDoc = objDOMParser.parseFromString(sResponseText, "text/xml");
				oDoc = objDoc;
				bLoaded = true;
			}
		}
		else
		{
			oDoc.async = false;
			bLoaded = oDoc.load("splash.xml");
		}
	}

	if (bLoaded)
	{
		var oSplash = oDoc.selectSingleNode("splash");

		var oSettings = oSplash.selectSingleNode("settings");

		var oShowSplash = oSettings.selectSingleNode("showsplash");
		var sShowSplash = oShowSplash.text;
		if (sShowSplash == "yes")
		{
			var oData = oSplash.selectSingleNode("data");
			var sData = oData.text;
			g_oBoardFrame.innerHTML = sData;
			return true;
		}
	}
	return false;
}
function StartModule(sSlideId, sFrameId)
{
	g_oDoc = CreateDOMDocument();

	var bLoaded = false;
	if (g_isMSIE)
	{
		g_oDoc.async = false;
		bLoaded = g_oDoc.load("runtime.xml");
	}
	else if (g_isFirefox)
	{
		var sWindowLocation = window.location;
		sWindowLocation = sWindowLocation.toString();
		sWindowLocation = sWindowLocation.toLowerCase()
		if(sWindowLocation.indexOf("http:")!=-1 || sWindowLocation.indexOf("https:")!=-1)
		{
			var oRequest = new XMLHttpRequest();
			oRequest.open('GET', 'runtime.xml', false);
			oRequest.send(null);
			if (oRequest.status == 200)
			{
				var sResponseText = oRequest.responseText;

				var objDOMParser = new DOMParser();
				var objDoc = objDOMParser.parseFromString(sResponseText, "text/xml");
				g_oDoc = objDoc;
				bLoaded = true;
			}
		}
		else
		{
			g_oDoc.async = false;
			bLoaded = g_oDoc.load("runtime.xml");
		}
	}

	if (bLoaded)
	{
		g_oModule = g_oDoc.selectSingleNode("module");
		g_oSlides = g_oModule.selectSingleNode("slides");
		g_oMasters = g_oModule.selectSingleNode("masters");
		g_oGroups = g_oModule.selectSingleNode("groups");
		g_oMethods = g_oModule.selectSingleNode("methods");
		g_oParams = g_oModule.selectSingleNode("params");

		{
			var oRuntime = g_oModule.selectSingleNode("runtime");

			var sSeqSlides = oRuntime.getAttribute("seqslides");
			g_bStrictOrder = (sSeqSlides == "yes");

			var sPreloadImages = oRuntime.getAttribute("preloadimages");
			g_bPreloadImages = (sPreloadImages == "yes");

			var sNormalize = oRuntime.getAttribute("normalize");
			g_bNormalize = (sNormalize == "yes");
		}

		CreateSCO();

		var bLoaded = LMSLoadState();

		ProcessRuntimeChecks();
		
		if((g_oEnv.Android || g_oEnv.iOS) && !g_oEnv.browser.isFF)
		{
			/* check if audio exists and ask user to tap once on audio to allow autoplay */
			var aSrcs = g_oSlides.selectNodes("//object[@soundsrc!='']");
			var aSnds = g_oParams.selectNodes("//param/*[contains(.,'.mp3') or contains(., '.MP3')]");
			if(aSrcs.length>0 || aSnds.length>0)
			{
				DisplayMask(true);
				DisplayAudioWarning(sSlideId, sFrameId);
			}
			else
			{
				ProceedStartModule(sSlideId, sFrameId);
			}
		}
		else
		{
			ProceedStartModule(sSlideId, sFrameId);
		}
	}
}
function DisplayAudioWarning(sSlideId, sFrameId)
{
	var iDivH = 240;
	var iDivW = 420;
	var iWinWidth = window.innerWidth;
	var iWinHeight = window.innerHeight;
	
	var oAudioDiv = document.createElement("div");
	oAudioDiv.setAttribute("id", "cl-audio-allow");
	oAudioDiv.className = "cl-audio-sample-div";
	oAudioDiv.style.width = iDivW + "px";
	oAudioDiv.style.left = Math.floor(0.5*(iWinWidth - iDivW - 40)) + "px";
	oAudioDiv.style.top = Math.floor(0.5*(iWinHeight - iDivH)) + "px";
	document.body.appendChild(oAudioDiv);
	
	var oTxt = document.createElement("div");
	oTxt.className = "cl-audio-sample-txt";
	oTxt.innerHTML = g_sAudioWarning;
	oAudioDiv.appendChild(oTxt);
	
	g_oAudioPlayer = document.createElement("audio");
	g_oAudioPlayer.setAttribute("id", "cl-audio-player");
	g_oAudioPlayer.setAttribute("controls", "controls");
	g_oAudioPlayer.className = "cl-audio-sample";
	oAudioDiv.appendChild(g_oAudioPlayer);
	
	var oBtn = document.createElement("input");
	oBtn.setAttribute("type", "button");
	oBtn.setAttribute("onclick", "AudioAllowed('" + (sSlideId==null ? "" : sSlideId) + "', '" + (sFrameId==null ? "" : sFrameId) + "')");
	oBtn.className = "cl-audio-proceed";
	oBtn.value = g_sProceed;
	oAudioDiv.appendChild(oBtn);
	
	return true;		
}
function AudioAllowed(sSlideId, sFrameId)
{
	DisplayMask(false);
	document.getElementById("cl-audio-allow").style.left = "-2000px";
	document.getElementById("cl-audio-allow").style.visibility = "hidden";
	ProceedStartModule(sSlideId, sFrameId);
	return true;
}
function ProceedStartModule(sSlideId, sFrameId)
{
	if(sSlideId=="") sSlideId = null;
	if(sFrameId=="") sFrameId = null;
	InitModule();

	var oSlide = null;

	if (sSlideId != null)
		oSlide = g_oSlides.selectSingleNode("slide[@id='"+sSlideId+"']");
	if (oSlide == null)
	{
		if (g_sLmsCmiLocation != "")
			oSlide = g_oSlides.selectSingleNode("slide[@id='"+g_sLmsCmiLocation+"']");
	}
	if (oSlide == null)
	{
		oSlide = GetFirstSlideFromStructureObject();
		if(oSlide==null) oSlide = g_oSlides.selectSingleNode("slide["+g_nFirst+"]");
	}

	OpenSlide(oSlide, sFrameId);

}
function Shutdown()
{
	try
	{
		if (g_oDocSCO != null)
		{
			var sSlideId = "";
			if (g_oSlide != null)
				sSlideId = g_oSlide.getAttribute("id");

			SCOApplyRules();

			g_sLmsCmiLocation = sSlideId;
			g_sLmsCmiExit = "suspend";

			LMSSaveState();
		}
	}
	catch (e)
	{
	}

	LMSShutdown();
}
function BeforeUnload()
{
	var tags = document.getElementsByTagName("object");
	for (var i = tags.length - 1; i >= 0; i--)
	{
		try
		{
			tags[i].parentNode.removeChild(tags[i]);
		}
		catch(e)
		{
		}
	}
}
function CheckBrowserType()
{
	var aChecks =
	[
		{ browser: "msie", checks: [ { type: "agent", value: "msie" } ], version: "msie " },
		{ browser: "ff", checks: [ { type: "agent", value: "firefox" } ], version: "firefox/" },
		{ browser: "chrome", checks: [ { type: "agent", value: "chrome" } ], version: "chrome/" },
		{ browser: "safari", checks: [ { type: "agent", value: "safari" }, { type: "vendor", value: "apple" } ], version: "version/" },
		{ browser: "opera", checks: [ { type: "prop", value: window.opera } ], version: "version/" },
		{ browser: "mozilla", checks: [ { type: "agent", value: "gecko" } ], version: "gecko/" }
	];
	var sBrowser = "";
	var nBrowserVersion = 0;
	var sUserAgent = navigator.userAgent.toLowerCase();
	var sVendor = navigator.vendor;
	if(sVendor==null) sVendor = "";
	sVendor = sVendor.toLowerCase();
	var i = 0;
	var j = 0;
	var bCheck = true;
	var iIdx;
	while(aChecks[i]!=null)
	{
		bCheck = true;
		j = 0;
		while(aChecks[i].checks[j]!=null)
		{
			switch(aChecks[i].checks[j].type)
			{
				case "prop": bCheck = (aChecks[i].checks[j].value!=null); break;
				case "agent": bCheck = RegExp(aChecks[i].checks[j].value).test(sUserAgent); break;
				case "vendor": bCheck = RegExp(aChecks[i].checks[j].value).test(sVendor); break;
				default: bCheck = false;
			}
			if(!bCheck) break;
			j++;
		}
		if(bCheck)
		{
			sBrowser = aChecks[i].browser;
			iIdx = sUserAgent.indexOf(aChecks[i].version);
			if(iIdx!=-1)
			{
				iIdx += aChecks[i].version.length;
				nBrowserVersion = parseFloat(sUserAgent.substr(iIdx));
			}
			break;
		}
		i++;
	}
	g_oEnv.browser = {};
	g_oEnv.SVG = {};
	if(g_isMSIE11)
	{
		sBrowser = "msie";
	}
	switch(sBrowser)
	{
		case "msie":
		{
			g_isMSIE = true;
			g_oEnv.browser.isIE = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.VML = true;
			g_sCSSPrefix = "ms";
			break;
		}
		case "ff":
		{
			g_isFirefox = true;
			g_oEnv.browser.isFF = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.SVG.inline = (nBrowserVersion>=4);
			g_oEnv.SVG.inject = (nBrowserVersion>=3);
			g_oEnv.SVG.append = (nBrowserVersion>=1);
			g_oEnv.SVG.type = (g_oEnv.SVG.inline) ? "inline" : ((g_oEnv.SVG.inject) ? "inject" : "append");
			g_sCSSPrefix = "moz";
			break;
		}
		case "chrome":
		{
			g_isFirefox = true;
			g_isWebkit = true;
			g_oEnv.browser.isChrome = true;
			g_oEnv.browser.isWebkit = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.SVG.inline = (nBrowserVersion>=7);
			g_oEnv.SVG.inject = (nBrowserVersion>=1);
			g_oEnv.SVG.append = (nBrowserVersion>=1);
			g_oEnv.SVG.type = (g_oEnv.SVG.inline) ? "inline" : ((g_oEnv.SVG.inject) ? "inject" : "append");
			g_sCSSPrefix = "webkit";
			break;
		}
		case "safari":
		{
			g_isFirefox = true;
			g_isWebkit = true;
			g_isSafari = true;
			g_oEnv.browser.isSafari = true;
			g_oEnv.browser.isWebkit = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.SVG.inline = (nBrowserVersion>=5.1);
			g_oEnv.SVG.inject = (nBrowserVersion>=4);
			g_oEnv.SVG.append = (nBrowserVersion>=1);
			g_oEnv.SVG.type = (g_oEnv.SVG.inline) ? "inline" : ((g_oEnv.SVG.inject) ? "inject" : "append");
			g_sCSSPrefix = "webkit";
			break;
		}
		case "opera":
		{
			g_isOpera = true;
			g_isFirefox = true;
			g_oEnv.browser.isOpera = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.SVG.inline = (nBrowserVersion>=12);
			g_oEnv.SVG.inject = (nBrowserVersion>=10);
			g_oEnv.SVG.append = (nBrowserVersion>=9);
			g_oEnv.SVG.type = (g_oEnv.SVG.inline) ? "inline" : ((g_oEnv.SVG.inject) ? "inject" : "append");
			g_sCSSPrefix = "o";
			break;
		}
		case "mozilla":
		{
			g_isFirefox = true;
			g_oEnv.browser.isFF = true;
			g_oEnv.browser.version = nBrowserVersion;
			g_oEnv.SVG.type = "append";
			g_sCSSPrefix = "moz";
			break;
		}
	}
	return true;
}
function _Node_getXML()
{
	var objXMLSerializer = new XMLSerializer;
	var strXML = objXMLSerializer.serializeToString(this);
	return strXML;
}
function UpdateFirefoxDOM()
{
	/* selectNodes */
	if (document.implementation.hasFeature("XPath", "3.0"))
	{
		XMLDocument.prototype.selectNodes =
			function (cXPathString, xNode)
			{
					if (!xNode)
						xNode = this;

					var oNSResolver = this.createNSResolver(this.documentElement)
					var aItems = this.evaluate(cXPathString, xNode, oNSResolver,
						XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null)
					var aResult = [];
					for (var i = 0; i < aItems.snapshotLength; i++)
						aResult[i] = aItems.snapshotItem(i);

					return aResult;
			}

		Element.prototype.selectNodes =
			function (cXPathString)
			{
				if (this.ownerDocument.selectNodes)
					return this.ownerDocument.selectNodes(cXPathString, this);
				else
					throw "For XML Elements Only";
			}
	}

	/* selectSingleNode */
	if (document.implementation.hasFeature("XPath", "3.0"))
	{
		/* prototyping the XMLDocument */
		XMLDocument.prototype.selectSingleNode =
			function (cXPathString, xNode)
			{
				if (!xNode)
					xNode = this;

				var xItems = this.selectNodes(cXPathString, xNode);
				if (xItems.length > 0)
					return xItems[0];
				else
					return null;
			}

		/* prototyping the Element */
		Element.prototype.selectSingleNode =
			function (cXPathString)
			{
				if (this.ownerDocument.selectSingleNode)
					return this.ownerDocument.selectSingleNode(cXPathString, this);
				else
					throw "For XML Elements Only";
			}
	}

	/* loadXML */
	Document.prototype.loadXML =
	function (sXML)
	{
		var objDOMParser = new DOMParser();
		var objDoc = objDOMParser.parseFromString(sXML, "text/xml");
		while (this.hasChildNodes())
			this.removeChild(this.lastChild);
		for (var i=0; i < objDoc.childNodes.length; i++)
		{
			var objImportedNode = this.importNode(objDoc.childNodes[i], true);
			this.appendChild(objImportedNode);
		}
	}

	Node.prototype.__defineGetter__("xml",
	function()
	{
		var oXMLSerializer = new XMLSerializer;
		var sXML = oXMLSerializer.serializeToString(this);
		return sXML;
	});

	/* text */
	Node.prototype.__defineGetter__("text",
	function()
	{
		if(this.textContent!=null) return this.textContent;
		var sText = "";
		var oText = this.firstChild;
		while (oText != null)
		{
			if (oText.nodeType == 3 || oText.nodeType == 4)
				sText += oText.nodeValue;

			oText = oText.nextSibling;
		}

		return sText;
	});

	g_nFirst = 1;
}
function DetermineMSXMLProgID()
{
	var oDoc;
	var sProgID;
	for (var i = 6; i >= 3; i--)
	{
		try
		{
			sProgID = "MSXML2.DOMDocument."+ i +".0";
			oDoc = new ActiveXObject(sProgID);
		}
		catch (e)
		{
		}
		if (typeof(oDoc) != "undefined")
		{
			g_sMSXMLProgID = sProgID;
			g_nFirst = (i <= 3 ? 0 : 1);
			break;
		}
	}
}
function DetermineMSXMLHTTPProgID()
{
	var oDoc;
	var sProgID;
	for (var i = 6; i >= 3; i--)
	{
		try
		{
			sProgID = "MSXML2.XMLHTTP."+ i +".0";
			oDoc = new ActiveXObject(sProgID);
		}
		catch (e)
		{
		}
		if (typeof(oDoc) != "undefined")
		{
			g_sMSXMLHTTPProgID = sProgID;
			break;
		}
	}
}
function CreateDOMDocument()
{
	var oDoc;

	if (g_isMSIE)
	{
		oDoc = new ActiveXObject(g_sMSXMLProgID);
	}
	else if (g_isFirefox)
	{
		oDoc = document.implementation.createDocument("", "doc", null);
	}

	return oDoc;
}
function CreateXMLHTTP()
{
	var oXmlHttp;

	if (g_isMSIE)
	{
		oXmlHttp = new ActiveXObject(g_sMSXMLHTTPProgID);
	}
	else if (g_isFirefox)
	{
		oXmlHttp = new XMLHttpRequest();
	}

	return oXmlHttp;
}
function ProcessRuntimeChecks()
{
	if(g_isMSIE11)
	{
		return true; /* isComponentInstalled deprecated by MS */
	}
	
	if (g_isMSIE)
		document.body.addBehavior("#default#clientCaps");

	var oRuntimeChecks = g_oModule.selectSingleNode("runtimechecks");
	if (oRuntimeChecks != null)
	{
		oRuntimeChecks = oRuntimeChecks.selectNodes("runtimecheck");
		var nRuntimeChecks = oRuntimeChecks.length;

		for (var i = 0; i < nRuntimeChecks; i++)
		{
			var oRuntimeCheck = oRuntimeChecks[i];
			var sId = oRuntimeCheck.getAttribute("id");
			switch (sId)
			{
				case "MSMP":
				{
					var sComponent = "Microsoft Windows Media Player";
					var bFound;
					if (g_isMSIE)
						bFound = GetIEComponent("22D6F312-B0F6-11D0-94AB-0080C74C7E95");
					else if (g_isFirefox)
						bFound = FindFirefoxPlugIn("Windows", "Media", "Player", "Plug-in");
					if (!bFound)
						alert(g_sComponent + sComponent + g_sIsNotInstalled);
					break;
				}

				case "MMFP":
				{
					var sComponent = "Macromedia Flash";
					var bFound;
					if (g_isMSIE)
						bFound = GetIEActiveX("ShockwaveFlash.ShockwaveFlash.1");
					else if (g_isFirefox)
						bFound = FindFirefoxPlugIn("Shockwave", "Flash");
					if (!bFound)
						alert(g_sComponent + sComponent + g_sIsNotInstalled);
					break;
				}

				case "MMSW":
				{
					var sComponent = "Macromedia Shockwave";
					var bFound;
					if (g_isMSIE)
						bFound = GetIEActiveX("SWCtl.SWCtl.8.5");
					else if (g_isFirefox)
						bFound = FindFirefoxPlugIn("Shockwave", "Director");
					if (!bFound)
						alert(g_sComponent + sComponent + g_sIsNotInstalled);
					break;
				}

				case "APQT":
				{
					var sComponent = "Apple QuickTime";
					var bFound;
					if (g_isMSIE)
						bFound = GetIEActiveX("QuickTime.QuickTime");
					else if (g_isFirefox)
						bFound = FindFirefoxPlugIn("QuickTime");
					if (!bFound)
						alert(g_sComponent + sComponent + g_sIsNotInstalled);
					break;
				}
			}
		}
	}
	return true;
}
function GetIEComponent(sActiveXClsID)
{
	var bFound = document.body.isComponentInstalled("{" + sActiveXClsID + "}", "ComponentID");
	return bFound;
}
function GetIEActiveX(sActiveXProgID)
{
	try
	{
		var oTestObject = new ActiveXObject(sActiveXProgID);
	}
	catch (e)
	{
		return false;
	}
	return true;
}
function FindFirefoxPlugIn()
{
	var arPlugins = navigator.plugins;
	var nPlugins = arPlugins.length;

	for (var i = 0; i < nPlugins; i++)
	{
		var sDescription = " " + arPlugins[i].description;
		var sName = " " + arPlugins[i].name;

		var bAllFound = true;
		for (j = 0; j < arguments.length; j++)
		{
			if (sDescription.indexOf(" " + arguments[j]) == -1 &&
				sName.indexOf(" " + arguments[j]) == -1)
				{
					bAllFound = false;
					break;
				}
		}
		if (bAllFound)
			return true;
	}
	return false;
}
function ReturnProgressObject()
{
	var oLoader = g_oModule.selectSingleNode("//object[@type='nav_024_loader']");
	if(oLoader==null) return null;
	return oLoader;
}
function GetFirstSlideFromStructureObject()
{
	var oStructure = g_oModule.selectSingleNode("//object[@type='nav_025_structure']");
	if(oStructure==null) return null;
	var sId = oStructure.getAttribute("id");
	var oParams = g_oParams.selectSingleNode("./param[@objectid='" + sId + "']");
	if(oParams==null) return null;
	var aChapters = oParams.selectNodes("chapter_list/item");
	var oSlide;
	var oSlideNode;
	var oChapter;
	for(var i=0; i<aChapters.length; i++)
	{
		oChapter = aChapters[i];
		sId = oChapter.selectSingleNode("chapter_title_slide").text;
		if(sId!="")
		{
			oSlide = g_oSlides.selectSingleNode("slide[@id='" + sId + "']");
			if(oSlide!=null) return oSlide;
		}
		oSlideNode = oChapter.selectSingleNode("slide_list/item/slide_id");
		if(oSlideNode!=null)
		{
			sId = oSlideNode.text;
			oSlide = g_oSlides.selectSingleNode("slide[@id='" + sId + "']");
			if(oSlide!=null) return oSlide;
		}
		sId = oChapter.selectSingleNode("chapter_final_slide").text;
		if(sId!="")
		{
			oSlide = g_oSlides.selectSingleNode("slide[@id='" + sId + "']");
			if(oSlide!=null) return oSlide;
		}
	}
	return null;
}
function SetEnvironmentVars()
{
	var sURL = (window.location.search=="") ? window.location.href : window.location.href.substring(0, window.location.href.indexOf("?"));
	var sSplitter = "/";
	var aSplitted = sURL.split(sSplitter);
	sURL = "";
	for(var i=0; i<aSplitted.length-2; i++) sURL += aSplitted[i] + sSplitter;
	g_sCourseImages = sURL + "courseimages" + sSplitter;
}
function TickTimeLine()
{
	if(g_aTimeLine[0]==null)
	{
		clearInterval(g_iTimeLineId);
		g_iTimeLineId = null;
		return false;
	}
	var iCurrentTime = (new Date()).valueOf();
	var iCnt = g_aTimeLine.length-1;
	var oTarget; 
	while(iCnt>=0)
	{
		if(g_aTimeLine[iCnt].time<=iCurrentTime)
		{
			oTarget = document.getElementById(g_aTimeLine[iCnt].targetid); 
			if(oTarget==null)
			{
				g_aTimeLine.splice(iCnt,1);
				iCnt--;
				continue;
			}
			g_aTimeLine[iCnt].func.apply(oTarget, [g_aTimeLine[iCnt].args])
			if(g_aTimeLine[iCnt].infinite==true)
			{
				g_aTimeLine[iCnt].time += g_aTimeLine[iCnt].delay;
				if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
			}
			else
			{
				g_aTimeLine.splice(iCnt,1);
			}
		}
		iCnt--;
	}
	if(g_aTimeLine[0]==null) return false;
	return true;
}
function DeferMethod(argobj)
{ 
	if(argobj.targetid==null || argobj.template==null || argobj.method==null || argobj.argobj==null) return false; 
	var oCurObj = document.getElementById(argobj.targetid);
	if(oCurObj==null) return false;
	if(argobj.delay==null)
	{
		CallMethod(argobj.template, argobj.method, argobj.argobj);
		return true;
	}
	var iDelay = parseFloat(argobj.delay);
	if(isNaN(iDelay)) iDelay = 1;
	iDelay = Math.round(iDelay*1000);
	var iTime = (new Date()).valueOf();
	iTime += iDelay;
	g_aTimeLine.unshift({ targetid: argobj.targetid, time: iTime, func: DeferMethod, args: { targetid: argobj.targetid, template: argobj.template, method: argobj.method, argobj: argobj.argobj } });
	if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
	return true;
}
function ProcessFFTranOut(argobj)
{
	if(argobj.targetid==null || argobj.transtype==null || argobj.transdur==null) return false;
	var oCurObj = document.getElementById(argobj.targetid);
	if(oCurObj==null) return false;
	var iDuration = parseFloat(argobj.transdur);
	if(isNaN(iDuration)) iDuration = 1;
	iDuration = Math.round(iDuration*1000);
	var sTransType = argobj.transtype.toString();
	if(sTransType=="23")
	{
		sTransType = Dice(22, true, []).toString();
		if(g_isMSIE11 && (sTransType=="12" || sTransType=="21" || sTransType=="22")) sTransType = "6";
	}
	if(sTransType=="12" || sTransType=="21" || sTransType=="22")
	{
		if(argobj.opacity==null)
		{
			var nCurOpacity = oCurObj.style.opacity;
			if(nCurOpacity==null)
			{
				nCurOpacity = 1;
			}
			nCurOpacity = parseFloat(nCurOpacity);
			if(isNaN(nCurOpacity))
			{
				nCurOpacity = 1;
			}
			var iStepQty = Math.round(iDuration/25);
			if(iStepQty<2) iStepQty = 2;
			if(iStepQty>50) iStepQty = 50;
			var iDelay = Math.floor(iDuration/iStepQty);
			var nTransStep = 1/iStepQty;
			var iTime = (new Date()).valueOf();
			var iTriggerTime = iTime;
			var oArgs = {};
			var iCnt = 1;
			while(iCnt<=iStepQty)
			{
				oArgs = { targetid: argobj.targetid, transtype: sTransType, transdur: iDuration, transstep: nTransStep, opacity: 1-nTransStep*iCnt };
				iTriggerTime = iTriggerTime + iDelay;
				g_aTimeLine.unshift({ targetid: argobj.targetid, time: iTriggerTime, func: ProcessFFTranIn, args: oArgs });
				iCnt++;
			}
			if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
			oCurObj.style.opacity = 1;
			oCurObj.style.visibility = "visible";
			return true;
		}
		if(argobj.opacity<0) argobj.opacity = 0;
		oCurObj.style.opacity = argobj.opacity;
	}
	else
	{
		if(argobj.clip==null)
		{
			var iStepQty = Math.round(iDuration/25);
			if(iStepQty<2) iStepQty = 2;
			if(iStepQty>50) iStepQty = 50;
			var iDelay = Math.floor(iDuration/iStepQty);
			var iWidth = oCurObj.offsetWidth + 4;
			var iHeight = oCurObj.offsetHeight + 4;
			var nTransStep = 1/iStepQty;
			var iTime = (new Date()).valueOf();
			var iTriggerTime = iTime;
			var oArgs = {};
			var iCnt = 1;
			while(iCnt<=iStepQty)
			{
				oArgs = { targetid: argobj.targetid, transtype: sTransType, transdur: iDuration, fullw: iWidth, fullh: iHeight, transstep: nTransStep, clip: 1-nTransStep*iCnt };
				iTriggerTime = iTriggerTime + iDelay;
				g_aTimeLine.unshift({ targetid: argobj.targetid, time: iTriggerTime, func: ProcessFFTranIn, args: oArgs });
				iCnt++;
			}
			if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
			oCurObj.style.visibility = "hidden";
			return true;
		}
		oCurObj.style.visibility = "visible";
		var nClip = parseFloat(argobj.clip);
		if(nClip<=0)
		{
			oCurObj.style.clip = "rect(auto, auto, auto, auto)";
			oCurObj.style.visibility = "hidden";
			return true;
		}	
		var iClipL;
		var iClipR;
		var iClipT;
		var iClipB;
		switch(sTransType)
		{
			case "0":
			case "1":
			case "2":
			case "3":
			{
				iClipL = Math.round((1+argobj.clip)*argobj.fullw/2);
				iClipR = Math.round((1-argobj.clip)*argobj.fullw/2);
				iClipT = Math.round((1-argobj.clip)*argobj.fullh/2);
				iClipB = Math.round((1+argobj.clip)*argobj.fullh/2);
				oCurObj.style.clip = "rect(" + iClipT + "px, " + iClipL + "px, " + iClipB + "px, " + iClipR + "px)";
				break;
			}
			case "4":
			{
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oCurObj.style.clip = "rect(auto, auto, " + iClipB + "px, auto)";
				break;
			}
			case "5":
			case "11":
			{
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oCurObj.style.clip = "rect(" + iClipT + "px, auto, auto, auto)";
				break;
			}
			case "6":
			case "10":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				oCurObj.style.clip = "rect(auto, auto, auto, " + iClipL + "px)";
				break;
			}
			case "7":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				oCurObj.style.clip = "rect(auto, " + iClipR + "px, auto, auto)";
				break;
			}
			case "8":
			case "13":
			case "14":
			{
				iClipL = Math.round((1+argobj.clip)*argobj.fullw/2);
				iClipR = Math.round((1-argobj.clip)*argobj.fullw/2);
				oCurObj.style.clip = "rect(auto, " + iClipL + "px, auto, " + iClipR + "px)";
				break;
			}
			case "9":
			case "15":
			case "16":
			{
				iClipT = Math.round((1-argobj.clip)*argobj.fullh/2);
				iClipB = Math.round((1+argobj.clip)*argobj.fullh/2);
				oCurObj.style.clip = "rect(" + iClipT + "px, auto, " + iClipB + "px, auto)";
				break;
			}
			case "17":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oCurObj.style.clip = "rect(auto, auto, " + iClipB + "px, " + iClipL + "px)";
				break;
			}
			case "18":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oCurObj.style.clip = "rect(" + iClipT + "px, auto, auto, " + iClipL + "px)";
				break;
			}
			case "19":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oCurObj.style.clip = "rect(auto, " + iClipR + "px, " + iClipB + "px, auto)";
				break;
			}
			case "20":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oCurObj.style.clip = "rect(" + iClipT + "px, " + iClipR + "px, auto, auto)";
				break;
			}
		}
	}
	return true;
}
function ProcessFFTranIn(argobj)
{
	if(argobj.targetid==null || argobj.transtype==null || argobj.transdur==null) return false;
	var oTarget = document.getElementById(argobj.targetid);
	if(oTarget==null) return false;
	var iDuration = parseFloat(argobj.transdur);
	if(isNaN(iDuration)) iDuration = 1;
	iDuration = Math.round(iDuration*1000);
	var sTransType = argobj.transtype.toString();
	if(sTransType=="23")
	{
		sTransType = Dice(22, true, []).toString();
		if(g_isMSIE11 && (sTransType=="12" || sTransType=="21" || sTransType=="22")) sTransType = "6";
	}
	if(sTransType=="12" || sTransType=="21" || sTransType=="22")
	{
		if(argobj.opacity==null)
		{
			var oObject = GetObjectById(argobj.targetid);
			var sOpacity = "100";
			if(oObject!=null)
			{
				sOpacity = oObject.getAttribute("alpha");
			}
			if(sOpacity==null || sOpacity=="") sOpacity = "100";
			var nCurOpacity = parseFloat(sOpacity)/100;
			if(nCurOpacity==null)
			{
				nCurOpacity = 1;
			}
			nCurOpacity = parseFloat(nCurOpacity);
			if(isNaN(nCurOpacity))
			{
				nCurOpacity = 1;
			}
			var iStepQty = Math.round(iDuration/25);
			if(iStepQty<2) iStepQty = 2;
			if(iStepQty>50) iStepQty = 50;
			var iDelay = Math.floor(iDuration/iStepQty);
			var nTransStep = nCurOpacity/iStepQty;
			var iTime = (new Date()).valueOf();
			var iTriggerTime = iTime;
			var oArgs = {};
			var iCnt = 1;
			while(iCnt<=iStepQty)
			{
				oArgs = { targetid: argobj.targetid, transtype: sTransType, transdur: iDuration, transstep: nTransStep, opacity: nTransStep*iCnt };
				iTriggerTime = iTriggerTime + iDelay;
				g_aTimeLine.unshift({ targetid: argobj.targetid, time: iTriggerTime, func: ProcessFFTranIn, args: oArgs });
				iCnt++;
			}
			if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
			oTarget.style.opacity = 0;
			oTarget.style.visibility = "visible";
			return true;
		}
		if(argobj.opacity>1) argobj.opacity = 1;
		oTarget.style.opacity = argobj.opacity;
	}
	else
	{
		if(argobj.clip==null)
		{
			var iStepQty = Math.round(iDuration/25);
			if(iStepQty<2) iStepQty = 2;
			if(iStepQty>50) iStepQty = 50;
			var iDelay = Math.floor(iDuration/iStepQty);
			var iWidth = oTarget.offsetWidth + 4;
			var iHeight = oTarget.offsetHeight + 4;
			var nTransStep = 1/iStepQty;
			var iTime = (new Date()).valueOf();
			var iTriggerTime = iTime;
			var oArgs = {};
			var iCnt = 1;
			while(iCnt<=iStepQty)
			{
				oArgs = { targetid: argobj.targetid, transtype: sTransType, transdur: iDuration, fullw: iWidth, fullh: iHeight, transstep: nTransStep, clip: nTransStep*iCnt };
				iTriggerTime = iTriggerTime + iDelay;
				g_aTimeLine.unshift({ targetid: argobj.targetid, time: iTriggerTime, func: ProcessFFTranIn, args: oArgs });
				iCnt++;
			}
			if(g_iTimeLineId==null || g_iTimeLineId==0) g_iTimeLineId = setInterval(TickTimeLine, g_iTimeLineTick);
			oTarget.style.visibility = "hidden";
			return true;
		}
		oTarget.style.visibility = "visible";
		var nClip = parseFloat(argobj.clip);
		if(nClip>=1)
		{
			oTarget.style.clip = "rect(auto, auto, auto, auto)";
			return true;
		}	
		var iClipL;
		var iClipR;
		var iClipT;
		var iClipB;
		switch(sTransType.toString())
		{
			case "0":
			case "1":
			case "2":
			case "3":
			{
				iClipL = Math.round((1+argobj.clip)*argobj.fullw/2);
				iClipR = Math.round((1-argobj.clip)*argobj.fullw/2);
				iClipT = Math.round((1-argobj.clip)*argobj.fullh/2);
				iClipB = Math.round((1+argobj.clip)*argobj.fullh/2);
				oTarget.style.clip = "rect(" + iClipT + "px, " + iClipL + "px, " + iClipB + "px, " + iClipR + "px)";
				break;
			}
			case "4":
			{
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oTarget.style.clip = "rect(" + iClipT + "px, auto, auto, auto)";
				break;
			}
			case "5":
			case "11":
			{
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oTarget.style.clip = "rect(auto, auto, " + iClipB + "px, auto)";
				break;
			}
			case "6":
			case "10":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				oTarget.style.clip = "rect(auto, " + iClipR + "px, auto, auto)";
				break;
			}
			case "7":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				oTarget.style.clip = "rect(auto, auto, auto, " + iClipL + "px)";
				break;
			}
			case "8":
			case "13":
			case "14":
			{
				iClipL = Math.round((1+argobj.clip)*argobj.fullw/2);
				iClipR = Math.round((1-argobj.clip)*argobj.fullw/2);
				oTarget.style.clip = "rect(auto, " + iClipL + "px, auto, " + iClipR + "px)";
				break;
			}
			case "9":
			case "15":
			case "16":
			{
				iClipT = Math.round((1-argobj.clip)*argobj.fullh/2);
				iClipB = Math.round((1+argobj.clip)*argobj.fullh/2);
				oTarget.style.clip = "rect(" + iClipT + "px, auto, " + iClipB + "px, auto)";
				break;
			}
			case "17":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oTarget.style.clip = "rect(auto, auto, " + iClipB + "px, " + iClipL + "px)";
				break;
			}
			case "18":
			{
				iClipL = Math.round(argobj.fullw*(1 - argobj.clip));
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oTarget.style.clip = "rect(" + iClipT + "px, auto, auto, " + iClipL + "px)";
				break;
			}
			case "19":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				iClipB = Math.round(argobj.fullh*argobj.clip);
				oTarget.style.clip = "rect(auto, " + iClipR + "px, " + iClipB + "px, auto)";
				break;
			}
			case "20":
			{
				iClipR = Math.round(argobj.fullw*argobj.clip);
				iClipT = Math.round(argobj.fullh*(1 - argobj.clip));
				oTarget.style.clip = "rect(" + iClipT + "px, " + iClipR + "px, auto, auto)";
				break;
			}
		}
	}
	return true;
}
function SwitchModal(sId, bOn)
{
	if(sId==null) return false;
	var oCurObj = document.getElementById(sId);
	if(oCurObj==null) return false;
	if(oCurObj.style.display=="none" || oCurObj.style.visibility=="hidden") return false;
	if(bOn)
	{
		DisplayMask(true);
		oCurObj.setAttribute("savedz", oCurObj.style.zIndex);
		oCurObj.style.zIndex = g_iMaskZIndex + 1;
	}
	else
	{
		DisplayMask(false);
		if(oCurObj.getAttribute("savedz")!=null)
		{
			oCurObj.style.zIndex = oCurObj.getAttribute("savedz");
			oCurObj.removeAttribute("savedz");
		}
	}
	return true;
}
function DisplayMask(bOn)
{
	var oMask = document.getElementById("boardMask");
	if(bOn)
	{
		var iWinWidth = (g_isMSIE) ? ((document.compatMode=="BackCompat") ? document.body.clientWidth : document.documentElement.clientWidth) : window.innerWidth;
		var iWinHeight = (g_isMSIE) ? ((document.compatMode=="BackCompat") ? document.body.clientHeight : document.documentElement.clientHeight) : window.innerHeight;
		if(oMask==null)
		{
			oMask = document.createElement("div");
			oMask.setAttribute("id", "boardMask");
			oMask.innerHTML = "&nbsp;";
			oMask.style.position = "absolute";
			oMask.style.top = "0px";
			oMask.style.left = "0px";
			oMask.style.backgroundColor = "#000000";
			var oMFilters = null;
			try
			{
				oMFilters = oMask.filters;
			}
			catch(e)
			{}
			if(g_isMSIE && oMFilters!=null)
			{
				oMask.style.filter = "alpha(opacity=50)";
			}
			oMask.style.mozOpacity = 0.5;
			oMask.style.webkitOpacity = 0.5;
			oMask.style.oOpacity = 0.5;
			oMask.style.opacity = 0.5;
			g_oBoardFrame.appendChild(oMask);
		}
		oMask.style.width = iWinWidth + "px";
		oMask.style.height = iWinHeight + "px";
		if(g_isMSIE && oMask.parentNode.nodeName!="div")
		{
			oMask.parentNode.removeChild(oMask); 
			g_oBoardFrame.appendChild(oMask); /* IE workaround to fix z-index order for dynamic objects */
		}
		oMask.style.visibility = "visible";
		oMask.style.zIndex = g_iMaskZIndex;
	}
	else
	{
		if(oMask!=null)
		{
			oMask.style.visibility = "hidden";
		}
	}
	return true;	
}
function GetNodeIndex(aNodes, oNode)
{
	var iCnt = 0;
	while(aNodes[iCnt]!=null)
	{
		if(aNodes[iCnt]==oNode) return iCnt;
		iCnt++;
	}
	return -1;
}
function PlayObjectSound(argobj)
{ 
	if(argobj.pid==null || argobj.snd==null) return false;
	var oCurObj = document.getElementById(argobj.pid);
	if(oCurObj==null) return false;
	var oParams = g_oParams.selectSingleNode("./param[@objectid='" + argobj.pid + "']");
	if(oParams==null) return false;
	if(oParams.selectSingleNode("sound.enabled").text=="yes")
	{
		try
		{
			var oSoundFile = oParams.selectSingleNode("sound.file." + argobj.snd);
			if(oSoundFile!=null)
			{
				var sSoundFile = oSoundFile.text;
				if(sSoundFile=="custom")
				{
					oSoundFile =  oParams.selectSingleNode("sound.file." + argobj.snd + ".user");
					if(oSoundFile!=null)
					{
						sSoundFile = oSoundFile.text;
						if(sSoundFile!="") PlaySoundInternal(sSoundFile);
					}
				}
				else
				{
					var sExtension = ".swf";
					PlaySoundInternal(g_sCourseImages + sSoundFile + sExtension);
				}
			}
		}
		catch(e) {}
	}
	return true;
}