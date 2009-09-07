<%@ include file="checkKmelia.jsp" %>
<%@ include file="tabManager.jsp.inc" %>

<%@ page import="com.silverpeas.publicationTemplate.*"%>
<%@ page import="com.silverpeas.form.*"%>

<%
Form 				formUpdate 	= (Form) request.getAttribute("Form");
DataRecord 			data 		= (DataRecord) request.getAttribute("Data"); 
PublicationDetail 	pubDetail 	= (PublicationDetail) request.getAttribute("CurrentPublicationDetail");
String				xmlFormName = (String) request.getAttribute("XMLFormName");
String				wizardLast	= (String) request.getAttribute("WizardLast");
String 				wizard		= (String) request.getAttribute("Wizard");
String 				wizardRow	= (String) request.getAttribute("WizardRow");
String				currentLang = (String) request.getAttribute("Language");

SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "formUpdate is null ? "+(formUpdate == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "data is null ? "+(data == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "pubDetail is null ? "+(pubDetail == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "xmlFormName is null ? "+(xmlFormName == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "wizardLast is null ? "+(wizardLast == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "wizard is null ? "+(wizard == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "wizardRow is null ? "+(wizardRow == null));
SilverTrace.debug("kmelia", "xmlForm.jsp", "root.MSG_GEN_ENTER_METHOD", "currentLang is null ? "+(currentLang == null));

String pubId 	= pubDetail.getPK().getId();
String pubName 	= pubDetail.getName(currentLang);

PagesContext 		context 	= new PagesContext("myForm", "2", resources.getLanguage(), false, componentId, kmeliaScc.getUserId());
context.setObjectId(pubId);
if (kmeliaMode)
	context.setNodeId(kmeliaScc.getSessionTopic().getNodeDetail().getNodePK().getId());
context.setBorderPrinted(false);
context.setContentLanguage(currentLang);

String linkedPathString = kmeliaScc.getSessionPath();

boolean isOwner = false;
if (kmeliaScc.getSessionOwner())
	isOwner = true;

if (wizardRow == null)
	wizardRow = "2";

boolean isEnd = false;
if ("2".equals(wizardLast))
	isEnd = true;

%>
<HTML>
<HEAD>
<% out.println(gef.getLookStyleSheet()); %>
<script type="text/javascript" src="<%=m_context%>/wysiwyg/jsp/FCKeditor/fckeditor.js"></script>
<% formUpdate.displayScripts(out, context); %>
<script language="javaScript">
function topicGoTo(id) {
	location.href="GoToTopic?Id="+id;
}

function B_VALIDER_ONCLICK()
{
	if (isCorrectForm())
	{
		document.myForm.submit();
	}
}

function B_ANNULER_ONCLICK() 
{
	location.href = "Main";
}

function closeWindows() {
    if (window.publicationWindow != null)
        window.publicationWindow.close();
}

function showTranslation(lang)
{
	location.href="ToPubliContent?SwitchLanguage="+lang;
}
</script>
</HEAD>
<BODY class="yui-skin-sam" onUnload="closeWindows()">
<%
    Window window = gef.getWindow();
    Frame frame = gef.getFrame();
    Board board = gef.getBoard();
    Board boardHelp = gef.getBoard();
    
    BrowseBar browseBar = window.getBrowseBar();
    browseBar.setDomainName(spaceLabel);
    browseBar.setComponentName(componentLabel, "Main");
    browseBar.setPath(linkedPathString);
	browseBar.setExtraInformation(pubName);
	browseBar.setI18N(pubDetail, currentLang);

	Button cancelWButton = (Button) gef.getFormButton(resources.getString("GML.cancel"), "ToPubliContent?WizardRow="+wizardRow, false);
		Button nextButton;
		if (isEnd)
			nextButton = (Button) gef.getFormButton(resources.getString("kmelia.End"), "javascript:onClick=B_VALIDER_ONCLICK();", false);
		else
			nextButton = (Button) gef.getFormButton(resources.getString("GML.next"), "javascript:onClick=B_VALIDER_ONCLICK();", false);
		
    out.println(window.printBefore());

    if ("progress".equals(wizard))
  		displayWizardOperations(wizardRow, pubId, kmeliaScc, gef, "ModelUpdateView", resources, out, kmaxMode);
  	  else
  	  {
	    if (isOwner)
	        displayAllOperations(pubId, kmeliaScc, gef, "ModelUpdateView", resources, out, kmaxMode);
	    else
	        displayUserOperations(pubId, kmeliaScc, gef, "ModelUpdateView", resources, out, kmaxMode);
  	  }

    out.println(frame.printBefore());
    out.println(board.printBefore());
    if (("finish".equals(wizard)) || ("progress".equals(wizard)))
	{
		//  cadre d'aide
	    out.println(boardHelp.printBefore());
		out.println("<table border=\"0\"><tr>");
		out.println("<td valign=\"absmiddle\"><img border=\"0\" src=\""+resources.getIcon("kmelia.info")+"\"></td>");
		out.println("<td>"+kmeliaScc.getString("kmelia.HelpContentXml")+"</td>");
		out.println("</tr></table>");
	    out.println(boardHelp.printAfter());
	    out.println("<BR>");
	}
%>
<FORM NAME="myForm" METHOD="POST" ACTION="UpdateXMLForm" ENCTYPE="multipart/form-data">
	<% 
		formUpdate.display(out, context, data); 
	%>
	<input type="hidden" name="Name" value="<%=xmlFormName%>">
</FORM>
<%
	out.println(board.printAfter());
	
	ButtonPane buttonPane = gef.getButtonPane();
	if (wizard.equals("progress"))
	{
		buttonPane.addButton(nextButton);
		buttonPane.addButton(cancelWButton);
	}
    else
    {
		buttonPane.addButton((Button) gef.getFormButton(resources.getString("GML.validate"), "javascript:onClick=B_VALIDER_ONCLICK();", false));
		buttonPane.addButton((Button) gef.getFormButton(resources.getString("GML.cancel"), "javascript:onClick=B_ANNULER_ONCLICK();", false));
    }
	out.println("<br><center>"+buttonPane.print()+"</center>");

    out.println(frame.printAfter());
%>
<% out.println(window.printAfter()); %>
</BODY>
<script language="javascript">
	document.myForm.elements[1].focus();
</script>
</HTML>