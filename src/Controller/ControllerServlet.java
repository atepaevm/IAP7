package Controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 12 on 20.03.2017.
 */
@WebServlet(name = "ControllerServlet", urlPatterns = {"/index.jsp"})
public class ControllerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String xString=request.getParameter("x_coord");
        String yString=request.getParameter("y_coord");
        String RString=request.getParameter("chBox");
        int x=1000;
        int y=1000;
        int R=1000;
        boolean isWrong=false;
        try{
            x=Integer.parseInt(xString);
            y=Integer.parseInt(yString);
            R=Integer.parseInt(RString);
        }
        catch (NumberFormatException e){
            isWrong=true;
        }
        if(!isWrong){
            if(x<-3||x>5||y<-5||y>3||R<0){
                isWrong=true;
            }
        }
        RequestDispatcher rd=null;
        if(!isWrong){
            rd=request.getRequestDispatcher("/checking");
            //request.getRequestDispatcher("/checking").forward(request,response);
        }
        else{
            rd=request.getRequestDispatcher("/index.jsp");
            List<AreaCheckServlet.Point> list=new ArrayList<>();
            System.out.println(list.size());
            list=(List<AreaCheckServlet.Point>)getServletConfig().getServletContext().getAttribute("list");
            System.out.println(list.size());
        }
        rd.forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
