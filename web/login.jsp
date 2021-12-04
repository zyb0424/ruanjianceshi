<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.lero.model.Admin" %>
<%@ page import="com.lero.model.DormManager" %>
<%@ page import="com.lero.model.Student" %>
<%
	if(request.getAttribute("user")==null){//获取保存在request作用域中的对象
		String userName=null;
		String password=null;
		String userType=null;
		String remember=null;

		Cookie[] cookies=request.getCookies();//获取客户端 cookie 对象
		for(int i=0;cookies!=null && i<cookies.length;i++){
			if(cookies[i].getName().equals("dormuser")){
				userName=cookies[i].getValue().split("-")[0];
				password=cookies[i].getValue().split("-")[1];
				userType=cookies[i].getValue().split("-")[2];
				remember=cookies[i].getValue().split("-")[3];
			}
		}

		if(userName==null){
			userName="";
		}

		if(password==null){
			password="";
		}

		if(userType==null){
			userType="";
		} else if("admin".equals(userType)){
			pageContext.setAttribute("user", new Admin(userName,password));//设置user属性
			pageContext.setAttribute("userType", 1);
		} else if("dormManager".equals(userType)) {
			pageContext.setAttribute("user", new DormManager(userName,password));
			pageContext.setAttribute("userType", 2);
		} else if("student".equals(userType)) {
			pageContext.setAttribute("user", new Student(userName,password));
			pageContext.setAttribute("userType", 3);
		}

		if("yes".equals(remember)) {
			pageContext.setAttribute("remember", 1);
		}

	}
%>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script type="text/javascript">
	function checkForm() {
		var userName = document.getElementById("userName").value;
		var password = document.getElementById("password").value;
		var userTypes = document.getElementsByName("userType");
		var userType = null;
		for(var i=0;i<userTypes.length;i++) {
			if(userTypes[i].checked) {
				userType=userTypes[i].value;
				break;
			}
		}
		if (userName == null || userName == "") {
			document.getElementById("error").innerHTML = "用户名不能为空";
			return false;
		}
		if (password == null || password == "") {
			document.getElementById("error").innerHTML = "密码不能为空";
			return false;
		}
		if (userType == null || userType == "") {
			document.getElementById("error").innerHTML = "请选择用户类型";
			return false;
		}
		return true;
	}
</script>

<style type="text/css">
	  body {
		  padding-top: 200px;
        background-image: url('images/bj5.jpg');
        background-position: center;
		background-repeat: no-repeat;
		background-attachment: fixed;
		  background-size: cover;
		  text-align: center;


      }
	  .container{
         background-color: white;
		  height: 300px;
		  width: 450px;
		  margin: auto;
		  border: 2px solid cyan;
		  border-radius: 20px;
		  text-align: center;
		  opacity: 0.7;
		  box-shadow: 10px 10px grey;

	  }
	  h1{
		  font-family: 华文行楷;

	  }
	  .text{
		  height: 40px;
		  width: 300px;
		  text-align: center;
		  margin: 10px;
		  border-radius: 10px;
	  }
	  .text:focus{

		  border-radius: 10px;
		  font-size: 20px;
          outline: none;
		  border: solid 3px chartreuse;
	  }
	  .text:hover{
		  font-size: 20px;
	  }


	  .select:hover{

		  background-color: yellow;
	  }
	  button:hover{
		  background-color: greenyellow;

	  }
	  .btn{text-align: center;
		  border-radius: 10px;
		  width: 100px;
		  height: 40px;
		  background-color:#0075b0;
		  font-size: 20px;
		  box-shadow: 5px 5px grey;
	  }

</style>

</head>
<body>
<div class="container">
      <form name="myForm" class="form-signin" action="login" method="post" onsubmit="return checkForm()">
       <fieldset style="border-radius: 20px">
        <legend align="center"> <h1>学生宿舍管理系统</h1></legend>
		  <label>
        <input id="userName" name="userName" value="${user.userName }" <%--从当前页面起开始搜寻 user对象，然后获取改对象的userName属性值--%>type="text" class="text" placeholder="请输入用户名..."><br/>
        <input id="password" name="password" value="${user.password }" type="password" class="text" placeholder="请输入密码..." ><br/>
		  </label>
			  <label class="select">
      	  	<input id="admin" type="radio" name="userType" value="admin"  checked/> 系统管理员
		</label>
		<label class="select">
			<input id="dormManager" type="radio" name="userType" value="dormManager" ${userType==2?'checked':''} /> 宿舍管理员
		</label>
		<label class="select">
			<input id="student" type="radio" name="userType" value="student"  ${userType==3?'checked':''}/> 学生<br/>
		</label>
        <label class="select">
          <input id="remember" name="remember" type="checkbox" value="remember-me" ${remember==1?'checked':''}>记住密码 &nbsp;&nbsp;&nbsp;&nbsp; <font id="error" color="red">${error }</font><br/>
        </label>
        <button class="btn" type="submit">登录</button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button class="btn" type="reset" >重置</button>

	   </fieldset>
      </form>
</div>
</body>
</html>