<%@ page import="Controller.AreaCheckServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<head>
    <style>
        #head {
            width: 300px;
            height: 40px;
            color: #DEAD00;
            background: #f0f0f0;
            font-family:fantasy;
            font-style: italic;
        }
        .indent {
            padding: 5%;
            margin: 2%;
        }
        input:hover {
            color: red;
        }
    </style>
    <style>
        .brd {
            border: 4px solid black;
            padding: 10px;
        }
    </style>
    <meta charset="UTF-8">
    <title>Form</title>
    <script src="parser.js"></script>
</head>
<body>
<header>
    <div id="head">
        Атепаев Михаил и Слобода Даниил
        группа P3210
        Вариант 10000
    </div>
</header>

<form action="ControllerServlet" id="sender" method="post" onsubmit="return checkValues();">
    <table>
        <tr>
            <td>
                X:  <input id="x_coord" type="text" required name="x_coord" class="indent">
            </td>
            <td>
                Y:<input id="y_coord" type="text" required name="y_coord" class="indent">
            </td>
        </tr>
        <tr>
            <td>
                R: <li>
                <ul><input type="checkbox" onclick="radioImitation(0)" name="chBox" value="1"> 1 </ul>
                <ul><input type="checkbox" onclick="radioImitation(1)" name="chBox" value="2"> 2 </ul>
                <ul><input type="checkbox" onclick="radioImitation(2)" name="chBox" value="3"> 3 </ul>
                <ul><input type="checkbox" onclick="radioImitation(3)" name="chBox" value="4"> 4 </ul>
                <ul><input type="checkbox" onclick="radioImitation(4)" name="chBox" value="5"> 5 </ul>
            </li>

            </td>
            <td>
                <canvas class="brd" id="graph" onclick="setPoint(event)" width="600" height="600"></canvas>
                <script type="text/javascript">
                    pixel_transform = 50;
                    checkBoxes = document.forms[0].elements.chBox;
                    canvas = document.getElementById("graph");
                    r = 0;
                    function setRadius(){
                        for(i = 0 ; i < checkBoxes.length; ++i){
                            if(checkBoxes[i].checked){
                                r = checkBoxes[i].value;
                            }
                        }
                    }
                    function radioImitation(num) {
                        r = 0;
                        for(i = 0; i < checkBoxes.length; i++){
                            if(i != num && checkBoxes[i].checked){
                                checkBoxes[i].checked = false;
                            }
                            if(checkBoxes[i].checked){
                                r = checkBoxes[i].value;
                            }
                        }
                        canvasFill();
                    }
                    function canvasFill(){
                        canvas.width = canvas.width
                        context = canvas.getContext("2d");
                        if(r > 0){
                            drawFigure(context);
                        }
                        drawCoordinates(context);
                    }
                    function setPoint(event){
                        rect = canvas.getBoundingClientRect();
                        offset = (rect.width - canvas.width)/2 + 1;
                        x = event.clientX - rect.left - offset;
                        y = event.clientY - rect.top - offset;
                        if(r == 0){
                            alert("Установите радиус сначала");
                        } else {
                            real_x = (x-300)/pixel_transform;
                            real_y = -(y-300)/pixel_transform;
                            console.log("real_x: " + real_x + " real_y: " + real_y);
                            //TODO: add server request
                            context = canvas.getContext("2d");
                            drawPoint(context, x, y, true);
                        }
                    }
                    function drawPoint(context, x, y, isInside){
                        context.beginPath();
                        if(isInside){
                            context.fillStyle = "Green";
                        } else {
                            context.fillStyle = "Black";
                        }
                        context.arc(x, y, 3, 0*Math.PI, 2*Math.PI);
                        context.fill();
                    }
                    function drawCoordinates(context){
                        context.beginPath();
                        /*Draw coordianates*/
                        context.moveTo(300, 600);
                        context.lineTo(300, 0);
                        context.lineTo(305, 5);
                        context.moveTo(300, 0);
                        context.lineTo(295, 5);
                        context.moveTo(0,300);
                        context.lineTo(600,300);
                        context.lineTo(595, 305);
                        context.moveTo(600,300);
                        context.lineTo(595,295);
                        if(r > 0){
                            pix = r * pixel_transform;
                            /*Draw measures*/
                            for(i = 300 + pix; i >= (300 - pix); i-=pix/2){
                                context.moveTo(295, i);
                                context.lineTo(305, i);
                                context.moveTo(i,295);
                                context.lineTo(i,305);
                            }
                        }
                        context.strokeStyle="black";
                        context.stroke();
                        /*Draw coordinates text*/
                        context.font = "16px Georgia";
                        context.textBaseline="top";
                        context.textAlign="left";
                        context.fillStyle="black";
                        context.fillText("Y", 310, 0);
                        context.textAlign="right";
                        context.textBaseline="bottom";
                        context.fillText("X", 600, 290);
                    }
                    function drawFigure(context){
                        pix = r * pixel_transform;
                        /*Arc fill*/
                        context.beginPath();
                        context.arc(299,301,r*pixel_transform,0.5*Math.PI,Math.PI);
                        context.moveTo((299 - r * pixel_transform),301);
                        context.lineTo(299,301);
                        context.lineTo(299,(301 + r*pixel_transform));
                        /*Triangle fill*/
                        context.moveTo((299 - r/2 *pixel_transform), 299);
                        context.lineTo(299, 299);
                        context.lineTo(299, (299 - r/2 *pixel_transform));
                        context.lineTo((299 - r/2 *pixel_transform), 299);
                        /*Rectangle fill */
                        context.rect(301,301, r*pixel_transform, r*pixel_transform );
                        context.closePath();
                        context.fillStyle="#5c99ED";
                        context.fill();
                        /*Figure Draw End*/
                    }
                    setRadius();
                    canvasFill();
                </script>
            </td>
        </tr>
    </table>
    <input type="submit" value="Отправить">
    <%
        List<AreaCheckServlet.Point> list=(ArrayList<AreaCheckServlet.Point>)getServletConfig().getServletContext().getAttribute("list");

        if(list!=null){
    out.println("<table border=\"1\" bordercolor=\"red\" >");
    out.println("<tr>");
        out.println("<td>");
            out.println("X coordinate");
            out.println("</td>");
        out.println("<td>");
            out.println("Y coordinate");
            out.println("</td>");
        out.println("<td>");
            out.println("Radius");
            out.println("</td>");
        out.println("<td>");
            out.println("Entrance");
            out.println("</td>");
        out.println("</tr>");

        for(int i=0;i<list.size();i++){
    out.println("<tr>");
        out.println("<td>");
            out.println(list.get(i).x);
            out.println("</td>");
        out.println("<td>");
            out.println(list.get(i).y);
            out.println("</td>");
        out.println("<td>");
            out.println(list.get(i).R);
            out.println("</td>");
        out.println("<td>");

            if(list.get(i).isInArea){
            out.println("Yes");
            }
            else{
            out.println("No");
            }

            out.println("</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    }

    %>

</form>
</body>