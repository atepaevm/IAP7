
function checkValues(){
	x = document.getElementById("x_coord").value;
	if(isNaN(x) || x > 5 || x < -3){
		alert("Неверный x");
		return false;
	}
    	y = document.getElementById("y_coord").value;
    	if(isNaN(y) || y < -5 || y > 3){
        	alert("Неверный y");
       		return false;
    	}
    	if(r == 0){
 		alert("Не установлен r");
		return false;
    	}
    	return true;
}

/*
function doRequest(){
	$.ajax({
       		 type:"get",
       		 url:"tribuneLoader.php",
       		 data:{
        	    x_coord: [1,2,3],
        	    y_coord: [-1,0,2],
       		    chBox: r 
        	},
    	success:onAjaxSuccess
	});
    function onAjaxSuccess(data){
        $("#result").append(data);
    }
}*/
