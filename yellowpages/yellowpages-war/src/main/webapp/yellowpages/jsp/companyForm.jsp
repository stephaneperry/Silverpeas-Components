<%--

    Copyright (C) 2000 - 2011 Silverpeas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    As a special exception to the terms and conditions of version 3.0 of
    the GPL, you may redistribute this Program in connection with Free/Libre
    Open Source Software ("FLOSS") applications as described in Silverpeas's
    FLOSS exception.  You should have recieved a copy of the text describing
    the FLOSS exception, and it is also available here:
    "http://repository.silverpeas.com/legal/licensing"

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", -1); //prevents caching at the proxy server
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.silverpeas.com/tld/viewGenerator" prefix="view" %>


<%@ include file="checkYellowpages.jsp" %>
<%@ include file="tabManager.jsp.inc" %>

<HTML>
<HEAD>
    <title><%=resources.getString("GML.popupTitle")%>
    </title>
    <view:looknfeel/>

    <script type="text/javascript" src="<%=m_context%>/util/javaScript/dateUtils.js"></script>
    <script type="text/javascript" src="<%=m_context%>/util/javaScript/checkForm.js"></script>
    <script type="text/javascript" src="<%=m_context%>/util/javaScript/animation.js"></script>
    <script language="javascript">

        function isCorrectForm() {
            var errorMsg = "";
            var errorNb = 0;
            var name = stripInitialWhitespace(document.companyForm.Name.value);
            var email = stripInitialWhitespace(document.companyForm.Email.value);
            var phone = stripInitialWhitespace(document.companyForm.Phone.value);
            var fax = stripInitialWhitespace(document.companyForm.Fax.value);

            if (isWhitespace(name)) {
                errorMsg += "  - <%=resources.getString("GML.theField")%> '<%=resources.getString("GML.name")%>' <%=resources.getString("GML.MustBeFilled")%>\n";
                errorNb++;
            }
            switch (errorNb) {
                case 0 :
                    result = true;
                    break;
                case 1 :
                    errorMsg = "<%=resources.getString("GML.ThisFormContains")%> 1 <%=resources.getString("GML.error")%> : \n" + errorMsg;
                    window.alert(errorMsg);
                    result = false;
                    break;
                default :
                    errorMsg = "<%=resources.getString("GML.ThisFormContains")%> " + errorNb + " <%=resources.getString("GML.errors")%> :\n" + errorMsg;
                    window.alert(errorMsg);
                    result = false;
                    break;
            }
            return result;
        }

        function submitForm() {
            if (isCorrectForm()) {
                document.companyForm.submit();
            }
        }

    </script>
</HEAD>
<body>

<%--
<view:browseBar path="<%=resources.getString('ContactCreation')%>" componentId="<%=componentId%>"/>
--%>
<view:window>
    <view:frame> s
        <view:board>
            <center>
                <form Name="companyForm" Action="companySave" Method="POST">
                    <table CELLPADDING=0 CELLSPACING=2 BORDER=0 WIDTH="98%">
                        <tr>
                            <td NOWRAP>
                                <table CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH="100%">
                                    <tr>
                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("GML.name")%>&nbsp;:
                                        </td>
                                        <td><input type="text" name="Name" value="${company.name}" size="60"
                                                   maxlength="60">&nbsp;<img border="0"
                                                                             src="<%=resources.getIcon("yellowpages.mandatory")%>"
                                                                             width="5" height="5"></td>
                                    </tr>
                                    <tr>

                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("GML.eMail")%>&nbsp;:
                                        </td>
                                        <td><input type="text" name="Email" value="${company.email}" size="60"
                                                   maxlength="100"></td>
                                    </tr>
                                    <tr>
                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("GML.phoneNumber")%>&nbsp;:
                                        </td>

                                        <td><input type="text" name="Phone" value="${company.phone}" size="20"
                                                   maxlength="20"></td>
                                    </tr>
                                    <tr>
                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("GML.faxNumber")%>&nbsp;:
                                        </td>

                                        <td><input type="text" name="Fax" value="${company.fax}" size="20"
                                                   maxlength="20"></td>
                                    </tr>
                                    <tr>
                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("GML.publisher")%>&nbsp;:
                                        </td>
                                        <td><%=yellowpagesScc.getUserDetail().getDisplayedName()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="baseline" align=left
                                            class="txtlibform"><%=resources.getString("ContactDateCreation")%>&nbsp;:
                                        </td>
                                        <td><%=resources.getOutputDate(new Date())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">(<img border="0"
                                                              src="<%=resources.getIcon("yellowpages.mandatory")%>"
                                                              width="5" height="5">
                                            : <%=resources.getString("GML.requiredField")%>)
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
            </center>
        </view:board>

        <view:buttonPane>
            <center>
                <view:button action="javascript:submitForm()" label='<%=resources.getString("GML.validate")%>'/>
                <view:button action="topicManager.jsp" label='<%=resources.getString("GML.cancel")%>'/>
            </center>
        </view:buttonPane>
    </view:frame>
</view:window>

</BODY>
</HTML>