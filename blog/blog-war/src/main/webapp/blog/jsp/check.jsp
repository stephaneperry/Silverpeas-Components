<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires",-1);          //prevents caching at the proxy server
%>

<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.*"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.Encode"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.window.Window"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.operationPanes.OperationPane"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.browseBars.BrowseBar"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.frame.Frame"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.ArrayPane"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.ArrayLine"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.ArrayColumn"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.ArrayCellText"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.ArrayCellLink"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.arrayPanes.*"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.iconPanes.IconPane"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.icons.Icon"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.tabs.TabbedPane"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.navigationList.NavigationList"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.buttonPanes.ButtonPane"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.buttons.Button"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.board.Board"%>

<%@ page import="com.stratelia.webactiv.util.*"%>
<%@ page import="com.stratelia.silverpeas.util.ResourcesWrapper"%>
<%@ page import="com.stratelia.webactiv.util.ResourceLocator"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.GraphicElementFactory"%>
<%@ page import="com.stratelia.silverpeas.peasCore.URLManager"%>

<%@ page import="com.stratelia.webactiv.util.GeneralPropertiesManager"%>

<%@ page import="java.util.Collection"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="com.silverpeas.blog.model.*"%>
<%@ page import="com.stratelia.webactiv.util.node.model.NodeDetail"%>
<%@ page import="com.stratelia.silverpeas.comment.model.Comment"%>
<%@ page import="com.stratelia.webactiv.util.publication.model.PublicationDetail"%>
<%@ page import="com.silverpeas.myLinks.model.LinkDetail"%>
<%@ page import="com.stratelia.webactiv.agenda.view.CalendarHtmlView"%>
<%@ page import="com.stratelia.webactiv.agenda.control.AgendaSessionController"%>
<%@ page import="com.stratelia.webactiv.calendar.model.SchedulableCount"%>
<%@ page import="com.stratelia.webactiv.util.viewGenerator.html.calendar.Calendar"%>
<%@ page import="com.silverpeas.util.StringUtil"%>
<%@ page import="com.stratelia.silverpeas.peasCore.MainSessionController"%>

<%@ page errorPage="../../admin/jsp/errorpageMain.jsp"%>

<%
GraphicElementFactory 	gef 				= (GraphicElementFactory) session.getAttribute("SessionGraphicElementFactory");
MainSessionController 	m_MainSessionCtrl 	= (MainSessionController) session.getAttribute("SilverSessionController");

String m_context = GeneralPropertiesManager.getGeneralResourceLocator().getString("ApplicationURL");

ResourcesWrapper resource = (ResourcesWrapper)request.getAttribute("resources");
Window window = gef.getWindow();
BrowseBar browseBar = window.getBrowseBar();
OperationPane operationPane = window.getOperationPane();
Frame frame = gef.getFrame();

String[] browseContext = (String[]) request.getAttribute("browseContext");
String spaceLabel = browseContext[0];
String componentLabel = browseContext[1];
String spaceId = browseContext[2];
String instanceId = browseContext[3];

String userId = m_MainSessionCtrl.getUserId(); 
%>