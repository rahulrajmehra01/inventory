<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Generate PDF Report</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
        function go(strReportFormat) {
            var strService = document.getElementById("txtService").value;
            var strVessel = document.getElementById("txtVessel").value;
            var strVoyage = document.getElementById("txtVoyage").value;
            var strPol = document.getElementById("txtPol").value;
            var strDirection = document.getElementById("cmbDirection").value;
            var strPolTerminal = document.getElementById("txtPolTerminal").value;
            var strReportName = document.getElementById("txtReportName").value;
            var strReportFormat = document.getElementById("txtReportFormat").value;
            
            var dataPost = {
                service: strService,
                vessel: strVessel,
                voyage: strVoyage,
                pol: strPol,
                direction: strDirection,
                polTerminal: strPolTerminal,
                reportName: strReportName,
                reportFormat: strReportFormat
            };

            $.ajax({
                type: "POST",
                url: '/RclJasperReportWS/jasper/jasperpdf/export',
                data: JSON.stringify(dataPost),
                contentType: "application/json",
                success: function(response) {
                    
                    var reportFormat = dataPost.reportFormat;
                    var reportName = dataPost.reportName;
					
					if (reportFormat === "E") {
						if(reportName === "MNR102_RSE" || reportName === "MNR101_RSE"){
						      var arrBuffer = base64DecToArr(response);
                              
                              var excelBlob = new Blob([arrBuffer], { type: "application/vnd.ms-excel" }); // Set correct MIME type
                              
                              var excelUrl = URL.createObjectURL(excelBlob);
                              
                              if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                                  window.navigator.msSaveOrOpenBlob(excelBlob, "MNRReport.xls"); // Save as Excel file
                                  return;
                              }
                              
                              var link = document.createElement("a");
                              link.href = excelUrl;
                              link.download = "MNRReport.xls"; // File name for download
                              document.body.appendChild(link);
                              link.click();
                              
                              // Clean up after download
                              setTimeout(() => {
                                  window.URL.revokeObjectURL(excelUrl);
                                  document.body.removeChild(link);
                              }, 0);
						} else {
						      var arrBuffer = base64DecToArr(response);
						      
                              // Create a Blob with a generic MIME type to avoid extensions
                              var htmlBlob = new Blob([arrBuffer], { type: "application/octet-stream" });
						      
                              // Create a URL for the Blob object
                              var htmlUrl = URL.createObjectURL(htmlBlob);
						      
                              if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                                  window.navigator.msSaveOrOpenBlob(htmlBlob, "rwservlet");
                                  return;
                              }
						      
                              // Create a link element to trigger the download without an extension
                              var link = document.createElement("a");
                              link.href = htmlUrl;
                              link.download = "rwservlet"; // No file extension
                              document.body.appendChild(link);
                              link.click();
						      
                              // Clean up the created URL after the download
                              setTimeout(() => {
                                  window.URL.revokeObjectURL(htmlUrl);
                                  document.body.removeChild(link);
                              }, 0);
					   }
					} else if(reportFormat === "P"){
					          var arrBuffer = base64DecToArr(response);

                  	          var newBlob = new Blob([arrBuffer], { type: "application/pdf" });

                  	          if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                  	              window.navigator.msSaveOrOpenBlob(newBlob);
                  	              return;
                  	          }

                              var data = window.URL.createObjectURL(newBlob);
                              document.getElementById("pdfViewer").setAttribute("src", data);
                    } 
                                        
                },
                error: function(error) {
                    console.log("Failed to generate report from Java!");
                },
                complete: function(xhr, status) {
                    console.log("Response status: " + status);
                }
            });
        }
        function b64ToUint6(nChr) {
            return nChr > 64 && nChr < 91
                ? nChr - 65
                : nChr > 96 && nChr < 123
                ? nChr - 71
                : nChr > 47 && nChr < 58
                ? nChr + 4
                : nChr === 43
                ? 62
                : nChr === 47
                ? 63
                : 0;
        }

        function base64DecToArr(sBase64, nBlocksSize) {
            const sB64Enc = sBase64.replace(/[^A-Za-z0-9+/]/g, "");
            const nInLen = sB64Enc.length;
            const nOutLen = nBlocksSize
                ? Math.ceil(((nInLen * 3 + 1) >> 2) / nBlocksSize) * nBlocksSize
                : (nInLen * 3 + 1) >> 2;
            const taBytes = new Uint8Array(nOutLen);

            let nMod3;
            let nMod4;
            let nUint24 = 0;
            let nOutIdx = 0;
            for (let nInIdx = 0; nInIdx < nInLen; nInIdx++) {
                nMod4 = nInIdx & 3;
                nUint24 |= b64ToUint6(sB64Enc.charCodeAt(nInIdx)) << (6 * (3 - nMod4));
                if (nMod4 === 3 || nInLen - nInIdx === 1) {
                nMod3 = 0;
                while (nMod3 < 3 && nOutIdx < nOutLen) {
                    taBytes[nOutIdx] = (nUint24 >>> ((16 >>> nMod3) & 24)) & 255;
                    nMod3++;
                    nOutIdx++;
                }
                nUint24 = 0;
                }
            }

          return taBytes;
        }
    </script>
</head>
<body>
	<h1>Generate PDF Report</h1>
	<form name="frm">
		<label>Service:</label> <input type="text" id="txtService"
			name="txtService"><br>
		<br> <label>Vessel:</label> <input type="text" id="txtVessel"
			name="txtVessel"><br>
		<br> <label>Voyage:</label> <input type="text" id="txtVoyage"
			name="txtVoyage"><br>
		<br> <label>Pol:</label> <input type="text" id="txtPol"
			name="txtPol"><br>
		<br> <label>Direction:</label> <select id="cmbDirection"
			name="cmbDirection">
			<option value="North">North</option>
			<option value="South">South</option>
			<option value="East">East</option>
			<option value="West">West</option>
		</select><br>
		<br> <label>Pol Terminal:</label> <input type="text"
			id="txtPolTerminal" name="txtPolTerminal"><br>
		<br> <label>Report Name:</label> <input type="text"
			id="txtReportName" name="txtReportName"><br>
		<br> <label>Report Format:</label> <input type="text"
			id="txtReportFormat" name="txtReportFormat"><br>
		<br>

		<button type="button" onclick="go('pdf')">Generate PDF</button>
	</form>

	<!-- iframe to display the generated PDF -->
	<iframe id="pdfViewer" width="100%" height="600px" frameborder="0"></iframe>
</body>
</html>
