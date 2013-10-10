<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
	<head>
		<title>Order</title>
		<link rel="stylesheet" href="<c:url value="/resources/blueprint/screen.css" />" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<c:url value="/resources/blueprint/print.css" />" type="text/css" media="print">
		<!--[if lt IE 8]>
			<link rel="stylesheet" href="<c:url value="/resources/blueprint/ie.css" />" type="text/css" media="screen, projection">
		<![endif]-->
		<script type="text/javascript" src="<c:url value="/resources/jquery-1.4.min.js" /> "> </script>
		<script type="text/javascript" src="<c:url value="/resources/json.min.js" /> "></script>
        <script type="text/javascript" src="<c:url value="/resources/canvas-all.js" /> "></script>
        <script>
            // Get the Signed Request from the CanvasUIController
            var sr =  JSON.parse('${not empty signedRequestJson?signedRequestJson:"{}"}');

            // Set handlers for the various buttons on the page
            Sfdc.canvas(function() {
                $('#finalizeButton').click(finalizeHandler);
                $('#deleteButton').click(deleteHandler);
            });

            // This function will be fred when the "Finalize" button is clicked.
            // This shows using the Canvas Cross Domain API to hit the REST API
            // for the invoice that the user is viewing.  The call updates the
            // Status__c field to "Shipped".  If successful, the page is refreshed,
            // and if there is an error it will alert the user.
            function finalizeHandler(){
                var invoiceUri=sr.context.links.sobjectUrl + "Invoice__c/${order.id}";
                var body = {"Status__c":"Shipped"};
                Sfdc.canvas.client.ajax(invoiceUri,{
                    client : sr.client,
                    method: 'PATCH',
                    contentType: "application/json",
                    data: JSON.stringify(body),
                    success : function() {
                        window.top.location.href = getRoot() + "/${order.id}";
                    },
                    error: function(){
                        alert("Error occurred updating local status.");
                    }
                });
            }

            // This function will be fred when the "Delete Order" button is clicked.
            // It will delete the record from the Heroku database.
            function deleteHandler(){
                $.deleteJSON("/order/${order.orderId}", function(data) {
                    alert("Deleted order ${order.orderId}");
                    location.href = "/orderui";
                }, function(data) {
                    alert("Error deleting order ${order.orderId}");
                });
                return false;
            }

            // This function gets the instance the user is on for a page referesh
            function getRoot() {
                return sr.client.instanceUrl;
            }

        </script>

        <style>
            #myTable {
                padding: 0px 0px 4px 0px;
            }

            #myTable td {
                border-bottom: 1px solid #CCCCCC;
            }

            .myCol {
                text-align: left;
                color: #4a4f5b;
                font-weight: bold;
            }

            .valueCol {
                padding-left:10px;
            }

            #bodyDiv {
                padding:0px;
                padding-top: 0px;
            }

            #OrderTitle {
                font-size: 1.2em;
                font-weight: bold;
                padding-right: 10px;
            }

            #myPageBlockTable {
                padding:5px;
                background: #F8F8F8;
                border: 1px solid #CDCDCD;
                border-radius: 6px;
                border-top: 3px solid #998c7c;
            }
        </style>

	</head>
	<body>
        <div id="bodyDiv" style="width:inherit;">
            <div id="myPageBlockTable">
                <h2 id="OrderTitle">
                    Order Number: <c:out value="${order.orderId}"/>
                </h2>
                <table id="myTable" width="100%">
                    <col width="20%">
                    <tr><td class="myCol">Invoice Id:</td><td class="valueCol"><c:out value="${invoice.id}"/></td></tr>
                    <tr><td class="myCol">Invoice Number:</td><td class="valueCol"><c:out value="${invoice.number}"/></td></tr>
                    <tr><td class="myCol">Status:</td><td class="valueCol" valign="center"><c:out value="${invoice.status}"/>
                        <!-- Display a green check if the order is Shipped, or a red x if not shipped -->
                        <c:choose>
                            <c:when test="${invoice.status == 'Shipped'}">
                                <img src="/resources/images/shipped.png" />
                            </c:when>
                            <c:otherwise>
                                <img src="/resources/images/pending.png" />
                            </c:otherwise>
                        </c:choose>
                    </td></tr>
                </table>
                <!-- Display the Back and Delete Order Button if viewed outside of salesforce (no signed request). -->
                <!-- Display the Finalize Button if viewed inside of salesforce and the Status is not Shipped. -->
                <c:choose>
                    <c:when test="${empty signedRequestJson}">
                        <button onclick="location.href='/orderui'">Back</button>
                        <button id="deleteButton">Delete Order</button>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${invoice.status ne 'Shipped'}">
                            <button id="finalizeButton">Finalize</button>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
	</body>
</html>