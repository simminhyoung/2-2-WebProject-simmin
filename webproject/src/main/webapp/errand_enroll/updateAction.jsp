<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="errand.Errand" %>
<%@ page import="errand.errandDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='../login/login.jsp'");
			script.println("</script>");	
		}
		int errandID=0;
		if(request.getParameter("errandID")!=null){
			errandID=Integer.parseInt(request.getParameter("errandID"));
		}
		if(errandID==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");	
		}
		Errand errand = new errandDAO().getErrand(errandID);
		if(!userID.equals(errand.getEnrollID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else{
			if(request.getParameter("errandTopic") == null || request.getParameter("errandDeadLine") == null || 
					request.getParameter("errandPlace") == null || request.getParameter("errandFee") == null ||
					request.getParameter("chattingLink") == null || request.getParameter("errandType") == null || 
					request.getParameter("errandContent") == null)
			{	
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다');");
				script.println("history.back();");
				script.println("</script>");
			} else {
				errandDAO ErrandDAO = new errandDAO();
				int result = ErrandDAO.update(errandID, request.getParameter("errandTopic"), request.getParameter("errandDeadLine"), request.getParameter("errandPlace"), request.getParameter("errandFee"), request.getParameter("chattingLink"), request.getParameter("errandType"), request.getParameter("errandContent"));

				if(result == -1) {
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				} else {
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("location.href='../main.jsp'");
					script.println("</script>");
				}
			}	
		}
	%>
</body>
</html>
