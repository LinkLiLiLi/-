<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title></title>
	<link rel="stylesheet" href="css/pintuer.css">
	<link rel="stylesheet" href="css/admin.css">
	<script src="js/jquery.js"></script>
	<script src="js/pintuer.js"></script>
	<script src="laydate/laydate.js"></script>
</head>
<body>
<form action="apply/online/transfer/list" method="post" id="searchForm">
  <jsp:include page="../include.jsp"/>
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="apply_transfer_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toadd()">创建转账单</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="请输入用途" name="use" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${use }" />
          <input type="text" placeholder="请输入支出项目" name="project" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${project }" />
          <input type="text" placeholder="请输入支出单位" name="unit" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${unit }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>收款单位</th>
		<th>金额</th>
		<th>汇款用途</th>
        <th>支出单位</th>				
		<th>支出项目</th>
		<th>财务编号</th>                
		<th>操作</th>
      </tr>
      <c:forEach items="${transferList}" var="record" varStatus="status">
     <tr>
      <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
      <td>${record.receiveUnit}</td>
      <td>${record.amount }</td>
      <td>${record.useInfo }</td>
      <td>${record.payUnit }</td>
      <td>${record.project.projectName}</td>
      <td>${record.number}</td>
      <td class="td-manage">
      	<div class="button-group">
      		<c:if test="${record.auditStatus == null || record.auditStatus == 2}">
       		<shiro:hasPermission name="apply_transfer_edit">
       		<a class="button border-main" onclick="toedit('${record.id}')" href="javascript:;">
       			<span class="icon-edit"></span> 编辑
       		</a>
       		</shiro:hasPermission>
       		<shiro:hasPermission name="apply_transfer_delete">
       		<a class="button border-red" onclick="todel('${record.id}')" href="javascript:;">
       			<span class="icon-trash-o"></span> 删除
       		</a>
       		</shiro:hasPermission>
       		</c:if>
       		<shiro:hasPermission name="apply_transfer_print">
       		<a class="button border-yellow" onclick="toprint('${record.id}')" href="javascript:;">
       			<span class="icon-print"></span> 打印
       		</a>
       		</shiro:hasPermission>
       		</div>
       </td>
     </tr>
     </c:forEach>
      	<jsp:include page="../../../include/page.jsp">
      		<jsp:param value="8" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		
		function toadd(){
			window.location.href="apply/online/transfer/toadd";
		}
		
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"ApplyTransfer"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
		}
		function toedit(id){
			window.location.href = "apply/online/transfer/toedit/"+id;
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
		function toprint(id){
			window.location.href = "apply/online/transfer/toprint/"+id;
		}
		
	</script>
</body>
</html>