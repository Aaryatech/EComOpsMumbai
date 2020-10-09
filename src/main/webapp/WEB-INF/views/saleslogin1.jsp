<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Madhvi</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway|Roboto"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=VT323'
	rel='stylesheet' type='text/css'>
<!-- jQuery -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js" />
	
<script src="https://code.jquery.com/jquery-1.8.2.min.js"></script>

    <!-- jQuery Popup Overlay -->
 <script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.popupoverlay.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/newpos/css/saleslogin.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
#overlay2 {
	position: fixed;
	display: none;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(239, 219, 219, 0.5);
	z-index: 10000;
	cursor: pointer;
}

#text2 {
	position: absolute;
	top: 50%;
	left: 50%;
	font-size: 25px;
	color: white;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	z-index: 10000;
}

 <!-- Custom styles for the popup page -->
 	/*.wellnew.popup_content{width: 25% !important; display:none; margin:0; min-height: 20px; padding: 19px;
    margin-bottom: 20px; background-color: #FFF !important; background:#FFF !important;}
	.wellnew 
    @media screen and (max-width:568px){
      .wellnew{width: 90% !important;}
    }*/
    
</style>
</head>

<body>
	<c:url var="checkValidEmployee" value="/checkValidEmployee" />
	<c:url var="getEmpDetails" value="/getEmpDetails" />
	<c:url var="checkOtp" value="/checkOtp" />
	<c:url var="changeToNewPassword" value="/changeToNewPassword" />
	<div style="color: #fff; text-align: right;">
		<a href="${pageContext.request.contextPath}/logout"><i
			class="fa fa-sign-out" aria-hidden="true"></i> Logout </a>
	</div>

	<div id="overlay2">
		<div id="text2">
			<img
				src="${pageContext.request.contextPath}/resources/newpos/images/loader.gif"
				alt="madhvi_logo">
		</div>
	</div>
	<div class="container">
		<c:forEach items="${empList}" var="empList">
			<input type="hidden" name="empId" id="empId${count.index}"
				value="${empList.frEmpId}" />
			<div class="items" id="items"
				onclick="showNumPad(${empList.frEmpId},'${empList.frEmpName}','${empList.frEmpContact}')">
				<div class="icon-wrapper">
					<i class="fa fa-user-o "></i>
				</div>
				<div class="project-name">
					<p>${empList.frEmpName}</p>
				</div>
			</div>
		</c:forEach>

		<div id="open-modal" class="modal-window">
			<div>




				<div class="keypad_wrapper">

					<div style="text-align: right;">
						<i class="fa fa-times" class="modal-close" onclick="hideNumPad()"
							style="color: #FD2549;"> </i>
					</div>

					<div class="items" style="border: 0px;">

						<div class="icon-wrapper">
							<i class="fa fa-user-o " style="color: #FD2549;"></i>
						</div>

						<div class="project-name">
							<p id="selectedEmp" style="color: #FD2549;"></p>
						</div>

						<div class="project-name">
							<p id="error" class="error" style="color: RED; display: none;">Loading...</p>
							<p id="success" class="success"
								style="color: limegreen; display: none;">SUCCESS</p>
						</div>

					</div>

					<div>


						<input type="password" class="screen" id="screen"
							placeholder="Password" autofocus="autofocus">
					</div>
					<input type="hidden" id="employeeId"  name="employeeId"><br>
					<input type="hidden" id="empContact"  name="empContact"><br>
					<a class="initialism basic_open" href="#basic" onclick="getMobileNo()">Forgot Password</a>
					<!--  onclick="getMobileNo()" -->


					<!-- <div class="flasher"></div> -->
					<!-- <div style="text-align: center;">
					<div class="error notification">ERROR</div>
					</div>
					
					<div class="success notification">SUCCESS</div> -->




					<!-- <div class="key">a</div>
	<div class="key">2</div>
	<div class="key">3</div>
	<div class="key">4</div>
	<div class="key">5</div>
	<div class="key">6</div>
	<div class="key">7</div>
	<div class="key">8</div>
	<div class="key">9</div>
	<div class="key last">0</div> -->

				</div>



				<!-- <a href="#" title="Close" class="modal-close">Forgot Password</a> -->
			</div>




		</div>
	</div>
	
	
	<!--basic pop up container-->
    <div id="basic" class="wellnew">
     <!--  <form action="" method="get">  -->
        <div class="mob_no" id="empMob"></div>
        <div class="frm_bx">
          <div class="frm_one">
          	<input name="otp" type="text" class="input_one" placeholder="Enter OTP" id="otp"/>
          	<span class="error_form text-danger" id="error_otp"
			style="display: none;">Invalid OTP.</span>
          </div>
          <button type="submit" onclick="validateOtp()" class="sub_btn" id="send_otp">Submit</button>    
          <button type="submit" onclick="resendOtp()" class="sub_btn" id="resend_btn" disabled="disabled">Resend OTP</button>    
          
        </div>
        <div class="basic_close close_btn"><i class="fa fa-times" aria-hidden="true"></i></div>
     <!--  </form>  -->
    </div>
    <!--End basic pop up container-->
    
    <!--Change Password Modal-->
     
    
    <div id="basic_pass" class="wellnew" style="display: none;">
      <form action="" method="get"> 
        <div class="mob_no" id="edit_pass_modal">Change Password</div>
        <div class="frm_bx">
          <div class="frm_one">
          	<input name="newPass" type="text" class="input_one" placeholder="Enter New Password" id="newPass"/>
          </div>
          
            <div class="frm_one">
          	<input name="confirmPass" type="text" class="input_one" placeholder="Enter Confirm Password" id="confirmPass"/>
          </div>
          <input name="" type="submit" value="Submit" onclick="updatePass()" class="sub_btn" />
        </div>
        <div class="basic_close close_btn"><i class="fa fa-times" aria-hidden="true"></i></div>
      </form> 
    </div> 
    
    
    <script type="text/javascript">
    $(document).ready(function () {
      $('#basic').popup();
    });
    </script>
    
    
	<script type="text/javascript">
	
    $(document).on("keypress", "input", function(e){

        if(e.which == 13){

            var inputVal = $(this).val();

          
            checkPwd();

        }

    });
	
	
	
	
		$(function() {
			$(document).on("keypress", function() {
				$("#screen").focus();
			});

		});

		$('#open-container').on('shown', function() {
			$('#screen').focus();
		})

		window.pass = "~~~~";
		window.redirectURL = '${pageContext.request.contextPath}/frLoginProcess';

		function showNumPad(empId, name, contact) {
		
			$.post('${checkValidEmployee}', {
				empId : empId,
				ajax : 'true'
			}, function(data) {
				//document.getElementById('screen').focus();
				window.pass = data;
			});
			var div = document.getElementById('open-modal');
			div.style.visibility = 'visible';

			div.style.opacity = '1';
			div.style.pointerEvents = "auto";
			document.getElementById('screen').focus();

			document.getElementById("selectedEmp").innerHTML = name;
			document.getElementById('empContact').value = contact;
			document.getElementById('employeeId').value = empId;
			document.getElementById("resend_btn").style.display = "none";
		}
		function hideNumPad() {

			var div = document.getElementById('open-modal');
			div.style.visibility = 'hidden';
			div.style.opacity = '0';
			div.style.pointerEvents = "none";
			$('.screen').html('');
			window.tries = 0;
			document.getElementById('screen').value = "";

		}
		$(document).ready(function() {
			start();
		});

		function start() {

			window.tries = 0;
			$('#screen').bind('input', function() {

				var n = $(this).html();
				
				$('.screen').append(n);
				window.tries++;
				updateFlasher();
				//validate();
			});
			
		}

		function updateFlasher() {

			if (window.tries <= 3) {
				var dis = window.tries * 55;
				$('.flasher').css({
					'left' : dis + 'px'
				});
			} else {
				$('.flasher').css({
					'left' : '20px',
					'display' : 'none'
				});
			}
		}

		function validate() {
			$('.error').hide();
			$('#screen').keyup(function(e) {
				

				if (e.keyCode == 13) {
					
					$('.error').hide();
					checkWin();
					$('.screen').val('');
					window.tries = 0;
					$('.flasher').css({
						'display' : 'block'
					});
				}
			});

		}

		function checkWin() {
			$('.error').hide();
			//$('.success').hide();
			
			var w = $('#screen').val();
			
			//alert(w+" ---------- "+window.pass);
			
			var flag=0;
			
			
			if (w == window.pass) {
				flag=1;

				document.getElementById("overlay2").style.display = "block";
				/* $('.error').hide();
				$('.success').show().delay(5000).queue(function(n) {
					$('.error').hide();
					$('.success').hide();
					n();
					hideNumPad();
					
				}); */
				var u = window.redirectURL;
				$(location).attr('href', u);
				
				//document.getElementById("overlay2").style.display = "none";
				

			} else {
				flag=0;
				
				/* $('.error').hide();
				$('.error').show().delay(1000).queue(function(n) {
					$('.error').hide();
					n();
					
				}); */
			}
			
		
			
			
			if(flag==1){
				
				document.getElementById("error").innerHTML = "Loading...";
				
				var u = window.redirectURL;
				$(location).attr('href', u);
				$('.error').hide();
				
				
			}else{
				
				
					$('.error').show();
					document.getElementById("error").innerHTML = "Invalid Password!";
				
				
				//$('.error').hide();
				/* $('.error').show().delay(1000).queue(function(n) {
					$('.error').hide();
					n();
					
				}); */
			}
			
		}
		
	/************************************************  */	
		function getMobileNo(){
			hideNumPad();
			var mob = $("#empContact").val();
			
			
			$.getJSON('${getEmpDetails}', {
				mob : mob,
				ajax : 'true'
			}, function(data) {
				document.getElementById("empMob").innerHTML = data.frEmpContact
				//alert("Emp---------"+JSON.stringify(data))

				
			}); 
		}
		function resendOtp(){
			var mob = $("#empContact").val();
			$.getJSON('${getEmpDetails}', {
				mob : mob,
				ajax : 'true'
			}, function(data) {
				//alert("Emp---------"+JSON.stringify(data))

			}); 
		}
	
	function validateOtp(){
		
		var otp = $("#otp").val();
		$.getJSON('${checkOtp}', {
			otp : otp,
			ajax : 'true'
		}, function(data) {
			
		///alert("OTP---------"+JSON.stringify(data))
			if(data.error!=true){
				$("#error_otp").show()
				document.getElementById('otp').value = '';
				document.getElementById("basic").style.display = "none";
				document.getElementById("basic_pass").style.display = "block";
				
			}else{				
				$("#error_otp").show()
				document.getElementById('otp').value = '';
				document.getElementById("resend_btn").style.display = "block";
				document.getElementById("resend_btn").disabled = false;
				
			}

			
		});
	}
	
	
function updatePass(){
	var employeeId = $("#employeeId").val();
		var newPass = $("#newPass").val();
		alert("newPass--------------"+newPass+" "+employeeId )
		$.getJSON('${changeToNewPassword}', {
			employeeId : employeeId,
			newPass : newPass,
			ajax : 'true'
		}, function(data) {
			
			alert("Emp---------"+JSON.stringify(data))
			if(error!=true){
			
				document.getElementById('empContact').value = '';
				document.getElementById('employeeId').value = '';
				document.getElementById("basic_pass").style.display = "none";
				
			}

			
		});
	}
	</script>
	
	<script type="text/javascript">
	

	function checkPwd() {
		$('.error').hide();
		//$('.success').hide();
		
		var w = $('#screen').val();
		
		//alert(w+" ---------- "+window.pass);
		
		var flag=0;
		
		
		if (w == window.pass) {
			flag=1;

			document.getElementById("overlay2").style.display = "block";
			var u = window.redirectURL;
			$(location).attr('href', u);

		} else {
			flag=0;
		}
		
		
		if(flag==1){
			document.getElementById("error").innerHTML = "Loading...";
			
			var u = window.redirectURL;
			$(location).attr('href', u);
			$('.error').hide();
			
		}else{
			
				$('.error').show();
				document.getElementById("error").innerHTML = "Invalid Password!";
				document.getElementById("screen").value = "";
		}
		
	}
	
	</script>



</body>
</html>