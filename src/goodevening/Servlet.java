 package goodevening;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PlanningServlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private ArrayList<Event> allEvents = new ArrayList<Event>();  //global. Pull once

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("in service");
		String username = "";
		int userID = -1;
		PrintWriter out = response.getWriter();


		if(request.getParameter("log-in") != null) {
			boolean error = false;
			username = request.getParameter("username");
        	String password = request.getParameter("password");
        	System.out.println(username + "in log-in");
        	if(username == "")
        	{
        		out.print("Invalid username.<br />");
        		error = true;
        	}
        	if(password == "")
        	{
        		out.print("Invalid password.<br />");
        		error = true;
        	}

        	if(error == false) {
        		Connection conn = null;
        		Statement st = null;
        		ResultSet rs = null;
        		ResultSet rs1 = null;
        		PreparedStatement ps = null;
        		PreparedStatement ps1 = null;
        		try {
        			Class.forName("com.mysql.jdbc.Driver"); // get driver for database
        			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false"); // use the last driver used in the memory (URI)

        			//Insert data about user if the user doesn't exists
        			ps = conn.prepareStatement("SELECT * FROM Users u WHERE u.username=?");
        			ps.setString(1, username);
        			rs = ps.executeQuery();
        			ps.clearParameters();
        			ps1 = conn.prepareStatement("SELECT * FROM Users u WHERE u.username=? AND u.userPassword=?");
        			ps1.setString(1, username);
        			ps1.setString(2, password);
        			rs1 = ps1.executeQuery();
        			ps1.clearParameters();
        			if(!rs.next()) //if the username doesn't exist
        			{
        				out.println("User doesn't exist.");
    					error = true;
        			}
        			else if(!rs1.next()) //if data not match
        			{
    					out.println("Username and password do not match.");
    					error = true;
        			}
        			else if(error == false) //data exist and no error
    				{
        				userID = rs.getInt("userID");
        				HttpSession session = request.getSession();
        				session.setAttribute("username", username);
        				out.println("success");
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
        				if(st != null) {
        					st.close();
        				}
        				if(conn != null) {
        					conn.close();
        				}
        			} catch (SQLException sqle) {
        				System.out.println("sqle closing conn: " + sqle.getMessage());
        			}
        		}
        	}
        	//session
    		HttpSession session = request.getSession();
    		session.setAttribute("userID", userID);

		}

		else if(request.getParameter("register") != null) {
			username = request.getParameter("username");
        	String password = request.getParameter("password");
        	System.out.println(username + " in register");
        	System.out.println(password + " in register");

        	boolean error = false;
        	if(username == "")
        	{
        		out.print("Invalid username.<br />");
        		error = true;
        	}
        	if(password == "")
        	{
        		out.print("Invalid password.<br />");
        		error = true;
        	}

        	if(error == false) {
        		Connection conn = null;
        		ResultSet rs = null;
        		PreparedStatement ps = null;
        		try {
        			Class.forName("com.mysql.jdbc.Driver"); // get driver for database
        			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false"); // use the last driver used in the memory (URI)

        			//Insert data about user if the user doesn't exists
        			ps = conn.prepareStatement("SELECT * FROM Users u WHERE u.username=?");
        			ps.setString(1, username);
        			rs = ps.executeQuery();
        			ps.clearParameters();
        			if(!rs.next()) //if data not exist
        			{
        				ps = conn.prepareStatement("INSERT INTO Users (username, userPassword) VALUES(?,?);");
        				ps.setString(1, username);
        				ps.setString(2, password);
        				ps.executeUpdate();
        				ps.clearParameters();
        				rs.close();
        			}
        			else //data exist, print error message
        			{
        				out.println("User already exists");
        				error = true;
        			}

        			if(error == false)
        			{
        				out.println("success");
        				ps.close();
        				ps = conn.prepareStatement("SELECT * FROM Users u WHERE u.username=?");
            			ps.setString(1, username);
            			rs = ps.executeQuery();
            			ps.clearParameters();
            			if(rs.next()) //if data exist
            			{
            				userID = rs.getInt("userID");
            				rs.close();
            				HttpSession session = request.getSession();
            				session.setAttribute("username", username);
            			}
        			}
        		} catch (SQLException sqle) {
        			System.out.println("sqle: " + sqle.getMessage());
        		} catch (ClassNotFoundException cnfe) {
        			System.out.println("cnfe: " + cnfe.getMessage());
        		} finally {
        			try {
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
        	//session
    		HttpSession session = request.getSession();
    		session.setAttribute("userID", userID);
		}
		else if(request.getParameter("guest") != null) {
			//session
			HttpSession session = request.getSession();
			session.setAttribute("userID", -1);
		}

		else if (request.getParameter("Restaurant") != null) {
			System.out.println("in planning");
			//fetch all events if not fetched yet
			if(allEvents.isEmpty()) {
				Connection conn = null;
	    		ResultSet rs = null;
	    		PreparedStatement ps = null;
				try {
	    			Class.forName("com.mysql.jdbc.Driver");
	    			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false");
	    			ps = conn.prepareStatement("SELECT * FROM EveningEvents");
	    			rs = ps.executeQuery();
	    			int i = 0;
	    			while(rs.next()) {
	    				i++;
						boolean timeDependent = false;
						if(rs.getInt("timeDependant") == 1) timeDependent = true;
	    				Event e = new Event(rs.getInt("eventID"),
											rs.getString("title"),
											rs.getString("pictureURL"),
											rs.getInt("startTime"),
											rs.getInt("endTime"),
											rs.getInt("duration"),
											rs.getString("location"),
											timeDependent,
											rs.getString("category"),
											rs.getString("subCategory"));
						allEvents.add(e);
	    			}
					System.out.println(i);
	    		} catch (SQLException sqle) {
	    			System.out.println("sqle: " + sqle.getMessage());
	    		} catch (ClassNotFoundException cnfe) {
	    			System.out.println("cnfe: " + cnfe.getMessage());
	    		} finally {
	    			try {
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

			//session
    		HttpSession session = request.getSession();
			userID = (int)session.getAttribute("userID");
			System.out.println("userID in planning: " + userID);
			//get user inputs, store in an ArrayList
			ArrayList<String> preferences = new ArrayList<>();
			preferences.add(request.getParameter("Restaurant"));
			preferences.add(request.getParameter("Movie"));
			preferences.add(request.getParameter("Exhibition"));
			preferences.add(request.getParameter("Shopping"));
			preferences.add(request.getParameter("Sightseeing"));
			preferences.add(request.getParameter("Show"));
			int eveningStart = Integer.parseInt(request.getParameter("eveningStart"));
		    int eveningEnd = Integer.parseInt(request.getParameter("eveningEnd"));


		    System.out.println("Preference: ");
		    for(int i = 0; i < preferences.size(); i++)
		    {
		    	System.out.print(i);
		    	System.out.println(preferences.get(i));
		    }

			//insert valid events (scores set) to options
			int eveningDuration = computeDuration(eveningStart, eveningEnd);
			System.out.println("duration: " + eveningDuration);
			ArrayList<Event> options = new ArrayList<>();
			for(Event e : allEvents) {
				if(e.getDuration() <= eveningDuration && (!e.isTimeDependent() ||
					e.isTimeDependent() && e.getStartTime() >= eveningStart && e.getEndTime() <= eveningEnd))
				{
					Event temp = new Event(e);
					temp.setScore(preferences);
                    System.out.println(temp.getCategory() + temp.getSubcategory() + temp.getScore());
					options.add(temp);
				}
			}
			int optionsNum = options.size();
			System.out.println("option size: " + optionsNum);

			//insert non-time-dependent events possibilities
			for(int i = 0; i < optionsNum; i++) {
				Event temp = options.get(i);
				if(!(temp.isTimeDependent())) {
					int newStart = eveningStart;
					int newEnd = addTime(eveningStart, temp.getDuration());

					//insert many possibilities of non-time-dependent events
                    while(newEnd <= eveningEnd) {
    					Event newOption = new Event(temp);
    					newOption.setStartTime(newStart);
    					newOption.setEndTime(newEnd);
                        int passedMin = timeToMin(minusTime(newStart, timeToMin(eveningStart)));
                        if(passedMin / newOption.getDuration() % 2 == 1) {
                            newOption.reduceScore();
                        }
    					options.add(newOption);
    					newStart = addTime(newStart, 20);
    					newEnd = addTime(newEnd, 20);
    				}
				}
			}
			//clean up original non-time-dependent events.
			for(int i = 0; i < options.size(); i++) {
				if(options.get(i).getStartTime() == 0) {
					options.remove(i);
					i--;
				}
			}

			ArrayList<Event> result = new AlgorithmThread(options).run();
			System.out.println("Results: ");
			for(int i = 0; i < result.size(); i++) {
				System.out.println(i + " " + result.get(i).getSummary());
			}

			if(result == null || result.isEmpty()) {
				out.println("<div id=sad-face></div>");
				return;  //don't need to store
			}
			else {
				out.print("<ul>");
				for(Event e : result) {
					out.println(e.getHTMLItem());
				}
				out.print("</ul>");
			}
			/*
			 Save arraylist to session variable instead of printwriter
			 */
			response.setContentType("text/html");
			session.setAttribute("result", result);

			if(userID != -1) {
				int eveningID = -1;
				//store to database
				Connection conn = null;
				Statement st = null;
				try {
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false");
					PreparedStatement ps = conn.prepareStatement("INSERT INTO EveningHistory(userID, startTime, endTime, eventID1, eventID2, eventID3, eventID4, eventID5, inUse) VALUES(?,?,?,?,?,?,?,?,?);",
	                        Statement.RETURN_GENERATED_KEYS);
					ps.setInt(1, userID);
					ps.setInt(2, eveningStart);
					ps.setInt(3, eveningEnd);
					for(int i = 0; i < 5; i++) {
						if(i < result.size()) {
							ps.setInt(i+4, result.get(i).getID());
						}
						else {
							ps.setInt(i+4, -1);
						}
					}
					ps.setInt(9, 0);
					ps.executeUpdate();
					ResultSet rs = ps.getGeneratedKeys();
					if (rs.next()){
			            eveningID =rs.getInt(1);
			        }
			        rs.close();
			        System.out.println("just inserted evening's ID: " + eveningID);
			        session.setAttribute("eveningID", eveningID);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				} catch (ClassNotFoundException cnfe) {
					System.out.println("cnfe: " + cnfe.getMessage());
				} finally {
					try {
						if(st != null) {
							st.close();
						}
						if(conn != null) {
							conn.close();
						}
					} catch (SQLException sqle) {
						System.out.println("sqle closing conn: " + sqle.getMessage());
					}
				}
			}

    	}

		else if(request.getParameter("displayHistory") != null) {
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            PreparedStatement ps2 = null;
            ResultSet rs2 = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false");
                HttpSession session = request.getSession();
                userID = (int)session.getAttribute("userID");
                System.out.println("in display history, userID: " + userID);
                ps = conn.prepareStatement("SELECT * FROM EveningHistory WHERE userID=" + userID + " AND inUse=1");
                rs = ps.executeQuery();
                PrintWriter pw = response.getWriter();
                pw.println("<h1>Past Evenings</h1>");
                pw.println("<table style='width:100%'>");


                while(rs.next()) {
                    String start = rs.getString("startTime");
                    String startTime = start.substring(0,2) + ":" + start.substring(2);
                    String end = rs.getString("endTime");
                    String endTime = end.substring(0,2) + ":" + end.substring(2);
                    int eveningId = rs.getInt("eveningID");
                    pw.println("<tr id='"+ eveningId + "'>");
                    pw.println("<th class='title'>" + startTime + "<br>-<br>" + endTime + "</th>");
                    for(int i = 1; i <= 5; i++) {
                        int currEventID = rs.getInt("eventID" + i);
                        if(currEventID >= 0) {
                            //Now need to get info of this event based on the id - will probably need to store it all somewhere, possibly a GoodEvening object??
                            ps2 = conn.prepareStatement("SELECT * FROM EveningEvents WHERE eventID=" + currEventID);
                            rs2 = ps2.executeQuery();
                            if(rs2.next()) {
                                String picURL = rs2.getString("pictureURL");
                                String title = rs2.getString("title");

                                pw.println("<th class='title'><div class='container'><img src='" + picURL + "' width='143' height='100' class='resultimage'><div class='overlay'>" + title + "</div></div></th>");
                            }
                        }

                    }

                    pw.println("<th class='title' onclick=sendMessage("+eveningId+") id='share" + eveningId + "'>Click to Share this Evening</th>");
                    pw.println("<th class='title' onclick=saveEvening("+eveningId+") id='save" + eveningId + "' style='visibility: hidden'>Click to Save this Evening</th>");
                    pw.println("</tr>");

                }
                pw.println("</table>");
                pw.flush();
                pw.close();

            }catch(SQLException sqle) {
                System.out.println("sqle: " + sqle.getMessage());
            } catch(ClassNotFoundException cnfe){
                System.out.println("cnfe: " + cnfe.getMessage());
            } finally {
                try {
                    if(ps != null) {
                        ps.close();
                    }
                    if(rs != null) {
                        rs.close();
                    }
                    if(st != null) {
                        st.close();
                    }
                    if(conn != null) {
                        conn.close();
                    }

                } catch (SQLException sqle) {
                    System.out.println("sqle closing streams: " + sqle.getMessage());
                }
            }
        }


		else if(request.getParameter("pokeUser") != null) {
			//TODO
		}

		else if(request.getParameter("logOutUser") != null) {
			System.out.println("logged-out");
			userID = -1;
			request.getSession().setAttribute("userID", -1);
		}
		else if(request.getParameter("save") != null) {
			Connection conn = null;
    		Statement st = null;
    		ResultSet rs = null;
    		PreparedStatement ps = null;
    		try {
    			Class.forName("com.mysql.jdbc.Driver"); // get driver for database
    			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false"); // use the last driver used in the memory (URI)

    			//Update the inUse in table EveningHistory
    			ps = conn.prepareStatement("UPDATE EveningHistory SET inUse=1 WHERE eveningID=?");
    			ps.setInt(1, (int)request.getSession().getAttribute("eveningID"));
    			ps.executeUpdate();

    		}catch(SQLException sqle) {
                System.out.println("sqle: " + sqle.getMessage());
            } catch(ClassNotFoundException cnfe){
                System.out.println("cnfe: " + cnfe.getMessage());
            } finally {
                try {
                    if(ps != null) {
                        ps.close();
                    }
                    if(rs != null) {
                        rs.close();
                    }
                    if(st != null) {
                        st.close();
                    }
                    if(conn != null) {
                        conn.close();
                    }

                } catch (SQLException sqle) {
                    System.out.println("sqle closing streams: " + sqle.getMessage());
                }
            }
		}
		else if(request.getParameter("saveEvening") != null) {
			System.out.println("In savingEvent");
			int eveningID = Integer.parseInt(request.getParameter("eveningID"));
			userID = (int)request.getSession().getAttribute("userID");
			Connection conn = null;
    		Statement st = null;
    		ResultSet rs = null;
    		ResultSet rs2 = null;
    		PreparedStatement ps = null;
    		PreparedStatement ps2 = null;
    		try {
    			Class.forName("com.mysql.jdbc.Driver"); // get driver for database
    			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GoodEveningDatabase?user=root&password=root&allowPublicKeyRetrieval=true&useSSL=false"); // use the last driver used in the memory (URI)

    			//get the record of the eveningID from the EveningHistory
    			ps = conn.prepareStatement("SELECT * FROM EveningHistory eh WHERE eh.eveningID=?");
    			ps.setInt(1, eveningID);
    			rs = ps.executeQuery();
                if(rs.next()) {
                    int startTime = rs.getInt("startTime");
                    int endTime = rs.getInt("endTime");
                    int eventID1 = rs.getInt("eventID1");
                    int eventID2 = rs.getInt("eventID2");
                    int eventID3 = rs.getInt("eventID3");
                    int eventID4 = rs.getInt("eventID4");
                    int eventID5 = rs.getInt("eventID5");
                    ps2 = conn.prepareStatement("INSERT INTO EveningHistory(userID, startTime, endTime, eventID1, eventID2, eventID3, eventID4, eventID5, inUse) VALUES(?,?,?,?,?,?,?,?,?);");
                    ps2.setInt(1, userID);
                    ps2.setInt(2, startTime);
                    ps2.setInt(3, endTime);
                    ps2.setInt(4, eventID1);
                    ps2.setInt(5, eventID2);
                    ps2.setInt(6, eventID3);
                    ps2.setInt(7, eventID4);
                    ps2.setInt(8, eventID5);
                    ps2.setInt(9, 1);
                    ps2.executeUpdate();
                }

    		}catch(SQLException sqle) {
                System.out.println("sqle: " + sqle.getMessage());
            } catch(ClassNotFoundException cnfe){
                System.out.println("cnfe: " + cnfe.getMessage());
            } finally {
                try {
                    if(ps != null) {
                        ps.close();
                    }
                    if(rs != null) {
                        rs.close();
                    }
                    if(ps2 != null) {
                    	ps2.close();
                    }
                    if(rs2 != null) {
                    	rs2.close();
                    }
                    if(st != null) {
                        st.close();
                    }
                    if(conn != null) {
                        conn.close();
                    }

                } catch (SQLException sqle) {
                    System.out.println("sqle closing streams: " + sqle.getMessage());
                }
            }
		}
//		//session
//		HttpSession session = request.getSession();
//		System.out.println("userID: " + (int)session.getAttribute("userID"));

	}

    private static int timeToMin(int start) {
        return start / 100 * 60 + start % 100;
    }

    private static int minToTime(int min) {
        return min / 60 * 100 + min % 60;
    }

    private static int addTime(int start, int time) {  //time is in minute
		int end = timeToMin(start) + time;
		return minToTime(end);
	}

	private static int minusTime(int end, int time) {  //time is in minute
		int start = timeToMin(end) - time;
		return minToTime(start);
	}

	private static int computeDuration(int start, int end) {
		start = timeToMin(start);
		end = timeToMin(end);
		return end - start;
	}

}

class AlgorithmThread {
    //each thread is responsible for: computing a result, return ArrayList<Event>

    private ArrayList<Event> events = new ArrayList<>();
    private double[] OPT;
    //stores index of the event that ends latest before event i
    private int[] compatible;

    public AlgorithmThread(ArrayList<Event> events) {
		for(Event e : events) {
            this.events.add(new Event(e));
        }  //events is not sorted, but only contain valid events
    }

    public ArrayList<Event> run() {
		if(events.isEmpty()) return null;
        events.sort((e1, e2) -> e1.getEndTime() - e2.getEndTime());
        //filling out compatible array
		compatible = new int[events.size()];
        for(int i = 0; i < compatible.length; i++) {
            compatible[i] = -1;
            int currentStart = events.get(i).getStartTime();
            //20 min for transportation
            if(currentStart % 100 < 20)
                currentStart = currentStart - 100 + 60;
            currentStart -= 20;

            for(int j = 0; j < i; j++) {
                if(events.get(j).getEndTime() <= currentStart) compatible[i] = j;
                else break;
            }
        }

        //filling out the OPT array
		OPT = new double[events.size() + 1];
        OPT[0] = 0;
        for(int i = 1; i < events.size() + 1; i++) {
            double scoreWith = events.get(i - 1).getScore();
            if(compatible[i - 1] > -1) scoreWith += OPT[compatible[i - 1] + 1];
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
        if(i < 0) return;
        else if(compatible[i] > -1 &&
                events.get(i).getScore() + OPT[compatible[i] + 1] > OPT[i]) {
            getEveningEvent(compatible[i], evening);
            evening.add(new Event(events.get(i)));
        }
		else if(compatible[i] < 0 && events.get(i).getScore() > OPT[i]) {
			evening.add(new Event(events.get(i)));
		}
        else {
            getEveningEvent(i - 1, evening);
        }
    }

}
