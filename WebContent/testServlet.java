package goodevening;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class testServlet
 */
@WebServlet("/testServlet")
public class testServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("in service");
		PrintWriter out = response.getWriter();
		if(request.getParameter("test") != null) {
			String html = "<li> <div id=\"eventTitle\">" + "eventSummary" + "</div>"
					+ "<div id=\"startTime\">" + "startTime" + "</div>"
					+ "<div id=\"endTime\">" + "endTime" + "</div>"
					+ "<div id=\"location\">" + "location" + "</div>"
					+ "<div id=\"category\">" + "category" + "</div>"
					+ "<div id=\"subCat\">" + "subCategory" + "</div>"
					+ "</li>";
			out.print(html);
		}
		
	}

}
