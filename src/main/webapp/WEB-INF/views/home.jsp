<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Excel</title>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
	function doExcelUploadProcess(){
		var formData = new FormData(document.getElementById('form1'));
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
		});
	}
	
	function doExcelDownloadProcess(){
		let f = $('#form1');
		f.attr("action","downloadExcelFile");
		console.log(f);
		f.submit();
	}
</script>
<form id="form1" method="post" enctype="multipart/form-data">
	<input type="file" name="fileInput" id="fileInput" />
	<button type="button" onclick="doExcelUploadProcess()">엑셀 업로드 작업</button>
	<button type="button" onclick="doExcelDownloadProcess()">엑셀 다운로드 작업</button>
</form>

<div id="result">

</div>

</body>
</html>
