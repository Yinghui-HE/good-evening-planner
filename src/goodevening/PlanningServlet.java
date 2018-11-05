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
@WebServlet("/PlanningServlet")
public class PlanningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private ArrayList<Event> options;
    private int eveningStart;
    private int eveningEnd;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlanningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //pull from database and occupy options
		//get user inputs, stored in an ArrayList<String> called preferences
        options.removeIf(e -> e.isTimeDependent() &&
                (e.getStartTime < eveningStart || e.getEndTime() > eveningEnd));
        //remove all invalid options
        plan();
    }

    //use threads to calculate the plan
    private void plan() {
        for(int i = 0; i < options.length(); i++) {
            Event temp = options.get(i);
            int duration = temp.getDuration();

            if(!(temp.isTimeDependent)) {
                //if event does not depend on time, try every possible interval
                //FIXME: this logic is incorrect
                options.remove(i);
                int currentStart = eveningStart;
                int currentEnd = addTime(currentStart, duration);

                while(currentEnd <= eveningEnd) {
                    currentEnd = currentStart + duration;
                    AlgorithmThread t = new AlgorithmThread(options);
                    t.start();
                    currentStart = addTime(currentStart, 20);
                }
            }
        }

    }

	//add time (in minutes) to start time
	private addTime(int start, int time) {
		int end = start + time / 60 * 100 + time % 60;
		return end + (end % 100 / 60) * (100 - 60);
	}

}

public class AlgorithmThread extends Thread {
    //each thread is responsible for: computing a result, sending it to front end

    private ArrayList<Event> events;
    private int[] OPT = new int[events.length()];
    //stores index of the event that ends latest before event i
    private int[] compatible = new int[events.length()];

    public AlgorithmThread(ArrayList<Event> events) {
        this.events = events;  //events is not sorted, but only contain valid events
    }

    @Override
    public void run() {
        try {
            events.sort((e1, e2) -> e1.getEndTime() < e2.getEndTime());
            //TODO: is this increasing order? getEndTime() should return int
            //filling out compatible array
            for(int i = 0; i < compatible.length(); i++) {
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
            for(int i = 1; i < events.length(); i++) {
                int scoreWith = events.get(i).getScore();
                if(compatible[i] > -1) scoreWith += OPT[compataible[i]];
                int scoreWithout = OPT[i - 1];
                OPT[i] = scoreWith > scoreWithout ? scoreWith : scoreWithout;
            }

            ArrayList<Event> evening = new ArrayList<>();
            getEveningEvent(events.length() - 1, evening);
            //TODO: send to front end and database

        }
        catch(InterruptedException ie) {
            System.out.println(ie.message());
        }
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
