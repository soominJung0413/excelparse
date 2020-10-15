<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Excel</title>
	<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<script type="text/javascript">
	function doExcelUploadProcess(){
/* 		var formData = new FormData(document.getElementById('form1'));
		$.ajax({
			url: 'uploadExcelFile',
			data: formData,
			contentType : false,
			processData : false,
			type : 'post',
			success : function(data){
				console.log(data);
				document.getElementById('result').innerHTML = JSON.stringify(data);
			}
		}); */
	}
	
	function doExcelDownloadProcess(){
		let f = $('#form1');
		f.attr("action","downloadExcelFile");
		console.log(f);
		f.submit();
	}
</script>
<form id="form1" method="post" action="/uploadExcelFile" enctype="multipart/form-data">
	<input type="file" name="fileInput" id="fileInput" />
	<button type="submit" onclick="doExcelUploadProcess()">엑셀 업로드 작업</button>
	<button type="button" onclick="doExcelDownloadProcess()">엑셀 다운로드 작업</button>
</form>

<c:if test="${not empty list}">
	<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">급여 종류</th>
      <th scope="col">직 종</th>
      <c:forEach begin="1" end="12" var="month">
      <th scope="col">${month}월</th>
		</c:forEach>
    </tr>
  </thead>
  <tbody>

  	<c:forEach items="${list}" var="excel">
    <tr>
      <th scope="row"  >${excel.sType }</th>
      <c:forEach items="${excel.occupants}" var="occupants">
      <td>${occupants.OType}</td>
      <td>${occupants.monthlySalary.jan}</td>
      <td>${occupants.monthlySalary.feb}</td>
      <td>${occupants.monthlySalary.mar}</td>
      <td>${occupants.monthlySalary.apr}</td>
      <td>${occupants.monthlySalary.may}</td>
      <td>${occupants.monthlySalary.jun}</td>
      <td>${occupants.monthlySalary.jul}</td>
      <td>${occupants.monthlySalary.aug}</td>
      <td>${occupants.monthlySalary.sep}</td>
      <td>${occupants.monthlySalary.oct}</td>
      <td>${occupants.monthlySalary.nov}</td>
      <td>${occupants.monthlySalary.dec}</td>
      </c:forEach>
    </tr>
	</c:forEach>
  </tbody>
</table>
</c:if>
</body>
</html>
