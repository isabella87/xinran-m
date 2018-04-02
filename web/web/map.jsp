<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="inc/common.jsp"%>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>  
<script src="<%=request.getContextPath() %>/themes/default/js/convetor.js"></script> 
<body>
   <%@include file="inc/head-page.jsp"%>
	<div style="width:800px;height:600px;border:1px solid gray" id="container"></div>  
	
<script type="text/javascript">  

var longitude;
var latitude;

if(navigator.geolocation){
    navigator.geolocation.getCurrentPosition(
        function (position) {  
            longitude = position.coords.longitude;  
            latitude = position.coords.latitude;  
            out.println(longitude);
            console.log(latitude);
            },
            function (e) {
             var msg = e.code;
             var dd = e.message;
             //console.log(msg)
             //console.log(dd)
        }
      ) 
}else{
	out.println("aaaa");
}
var map = new BMap.Map("container");  // 创建地图实例  
//var longitude=getUrlParam("longitude");//经度  
//var latitude=getUrlParam("latitude");//纬度  
 longitude="121.536465";//经度  
 latitude="31.274093";//纬度  
var point = new BMap.Point(longitude, latitude);  // 创建点坐标  
map.centerAndZoom(point, 15);  // 初始化地图，设置中心点坐标和地图级别  
map.addControl(new BMap.NavigationControl()); //添加平移缩放控件  
map.addControl(new BMap.ScaleControl());  //添加放大、缩小控件  
map.enableScrollWheelZoom();//允许鼠标滑轮操作  
  


//坐标转换完之后的回调函数  
  
translateCallback = function (point){  
  
  //设置标注的图标
    var icon = new BMap.Icon("<%=request.getContextPath() %>"+"/themes/default/images/seal.png",new BMap.Size(100,100));
    var marker = new BMap.Marker(point,{icon:icon});  
    
    //根据坐标得到地址描述    
    var myGeo = new BMap.Geocoder();    
    myGeo.getLocation(point, function(result){    
        if (result){    
            var label = new BMap.Label(result.address,{offset:new BMap.Size(20,-10)});  
            marker.setLabel(label);  
        }});    
      
    // 将标注添加到地图中  
    map.addOverlay(marker);  
      
    //将坐标设置为地图中心位置  
    map.setCenter(point);  
}  
  
  
  
setTimeout(function(){  
    BMap.Convertor.translate(
    		new BMap.Point(longitude, latitude),0,translateCallback);     //真实经纬度转成百度坐标  
}, 2000);  
  
  
  
</script>  
	
</body>
</html>
