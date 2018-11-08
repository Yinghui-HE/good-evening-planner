package goodevening;

import java.io.IOException;
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

    private ArrayList<Event> options;
    private int eveningStart;
    private int eveningEnd;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Log in part code in Servlet
		if(request.getParameter("field") != null && ((String)request.getParameter("field")).equals("log-in"))
        {
        	String username = request.getParameter("username");
        	String password = request.getParameter("password");
        	System.out.println(username);
        }
		
		
		//pull from database and occupy options
		//get user inputs, stored in an ArrayList<String> called preferences
		//remove all invalid options
		int eveningDuration = computeDuration(eveningStart, eveningEnd);
		options.removeIf(e -> e.isTimeDependent() &&
                (e.getStartTime() < eveningStart || e.getEndTime() > eveningEnd) ||
				e.getDuration() > eveningDuration);
		int optionsNum = options.size();
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

public class AlgorithmThread {
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
        //TODO: is this increasing order?
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
