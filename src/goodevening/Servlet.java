package goodevening;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PlanningServlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private ArrayList<Event> allEvents;  //global. Pull once

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = "";
		if(request.getParameter("log-in") != null) {
			username = request.getParameter("username");
        	String password = request.getParameter("password");
        	System.out.println(username + "in log-in");


		}

		else if(request.getParameter("register") != null) {
			username = request.getParameter("username");
        	String password = request.getParameter("password");
        	System.out.println(username + " in register");
        	System.out.println(password + " in register");


        	Connection conn = null;
    		ResultSet rs = null;
    		PreparedStatement ps = null;
    		try {
    			Class.forName("com.mysql.jdbc.Driver"); // get driver for database
    			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&useSSL=false"); // use the last driver used in the memory (URI)

    			//Insert data about user if the user doesn't exists
    			ps = conn.prepareStatement("SELECT * FROM Users u WHERE u.username=?");
    			ps.setString(1, username);
    			rs = ps.executeQuery();
    			ps.clearParameters();
    			if(!rs.next()) //if data not exists
    			{
    				ps = conn.prepareStatement("INSERT INTO Users (username, userPassword) VALUES(?,?);");
    				ps.setString(1, username);
    				ps.setString(2, password);
    				ps.executeUpdate();
    				ps.clearParameters();
    				rs.close();
    			}


    		} catch (SQLException sqle) {
    			System.out.println("sqle: " + sqle.getMessage());
    		} catch (ClassNotFoundException cnfe) {
    			System.out.println("cnfe: " + cnfe.getMessage());
    		} finally {
    			try {
    				if(rs != null) {
    					rs.close();
    				}
    				if(ps != null) {
    					ps.close();
    				}
    				if(conn != null) {
    					conn.close();
    				}
    			} catch (SQLException sqle) {
    				System.out.println("sqle closing conn: " + sqle.getMessage());
    			}
    		}
		}

		else if (request.getParameter("moviePreference") != null) {
			//TODO: pull from database and occupy allEvents
			if(allEvents.isEmpty()) {
				Connection conn = null;
	    		ResultSet rs = null;
	    		PreparedStatement ps = null;
				try {}
			}

			//get user inputs, store in an ArrayList
			ArrayList<String> preferences = new ArrayList<>();
			preferences.add(request.getParameter("restaurant"));
			preferences.add(request.getParameter("movie"));
			preferences.add(request.getParameter("exhibition"));
			preferences.add(request.getParameter("concert"));
			preferences.add(request.getParameter("outdoor"));
			int eveningStart = Integer.parseInt(request.getParameter("eveningStart"));
		    int eveningEnd = Integer.parseInt(request.getParameter("eveningEnd"));


			//insert valid events (scores set) to options
			int eveningDuration = computeDuration(eveningStart, eveningEnd);
			for(Event e : allEvents) {
				if( (!e.isTimeDependent() ||
					e.isTimeDependent() && e.getStartTime() >= eveningStart && e.getEndTime() <= eveningEnd)
					&& e.getDuration() <= eveningDuration )
				{
					Event temp = new Event(e);
					temp.setScore(preferences);
					options.add(temp);
				}
			}
			options.removeIf(e -> e.isTimeDependent() &&
	                (e.getStartTime() < eveningStart || e.getEndTime() > eveningEnd) ||
					e.getDuration() > eveningDuration);
			int optionsNum = options.size();

			//insert non-time-dependent events possibilities
			for(int i = 0; i < optionsNum; i++) {
				Event temp = options.get(i);
				if(!(temp.isTimeDependent())) {
					int newStart = eveningStart;
					int newEnd = addTime(eveningStart, temp.getDuration());
					options.remove(i);
					i--;
					//insert many possibilities of non-time-dependent events
					while(newEnd <= eveningEnd) {
						Event newOption = new Event(temp);
						newOption.setStartTime(newStart);
						newOption.setEndTime(newEnd);
						options.add(newOption);
						newStart = addTime(newStart, 20);
						newEnd = addTime(newEnd, 20);
					}
					//TODO: testing needed
				}
			}
			ArrayList<Event> result = new AlgorithmThread(options).run();
			//TODO
    	}

		else if(request.getParameter("displayHistory") != null) {
			//TODO
		}

		else if(request.getParameter("pokeUser") != null) {
			//TODO
		}

		else if(request.getParameter("logOutUser") != null) {
			//TODO
		}
	}


	//add time (in minutes) to start time
	private int addTime(int start, int time) {
		int end = start + time / 60 * 100 + time % 60;
		return end + (end % 100 / 60) * (100 - 60);
	}

	private int minusTime(int end, int time) {
		int start = end - time / 60 * 100 + time % 60;
		return start + (start % 100 / 60) * (100 - 60);
	}

	private int computeDuration(int start, int end) {
		start = start / 100 * 60 + start % 100;
		end = end / 100 * 60 + start % 100;
		return end - start;
	}

}

class AlgorithmThread {
    //each thread is responsible for: computing a result, sending it to front end

    private ArrayList<Event> events;
    private double[] OPT = new double[events.size()];
    //stores index of the event that ends latest before event i
    private int[] compatible = new int[events.size()];

    public AlgorithmThread(ArrayList<Event> events) {
        this.events = events;  //events is not sorted, but only contain valid events
    }

    public ArrayList<Event> run() {
        events.sort((e1, e2) -> e1.getEndTime() - e2.getEndTime());
        //FIXME: make sure this is increasing order
        //filling out compatible array
        for(int i = 0; i < compatible.length; i++) {
            compatible[i] = -1;
            int currentStart = events.get(i).getStartTime();
            //half an hour for transportation
            if(currentStart % 100 < 30)
                currentStart = currentStart - 100 + 60;
            currentStart -= 30;

            for(int j = 0; j < i; j++) {
                if(events.get(j).getEndTime() <= currentStart) compatible[i] = j;
                else break;
            }
        }

        //filling out the OPT array
        OPT[0] = 0;
        for(int i = 1; i < events.size(); i++) {
            double scoreWith = events.get(i).getScore();
            if(compatible[i] > -1) scoreWith += OPT[compatible[i]];
            double scoreWithout = OPT[i - 1];
			if(scoreWith > scoreWithout)
				OPT[i] = scoreWith;
            else
				OPT[i] = scoreWithout;
        }

        ArrayList<Event> evening = new ArrayList<>();
        getEveningEvent(events.size() - 1, evening);
        return evening;
    }

    //trace back to insert events that maximize scoring
    private void getEveningEvent(int i, ArrayList<Event> evening) {
        if(i == 0) return;
        else if(compatible[i] > -1 &&
                events.get(i).getScore() + OPT[compatible[i]] > OPT[i - 1]) {
            getEveningEvent(compatible[i], evening);
            evening.add(events.get(i));
        }
        else {
            getEveningEvent(i - 1, evening);
        }
    }

}
