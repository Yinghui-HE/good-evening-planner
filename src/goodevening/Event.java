package goodevening;

public class Event {
	public final static int UNPREFERRED_SCORE = 1;
    public final static int NORMAL_SCORE = 3;
    public final static int PREFERRED_SCORE = 9;
	private String eventSummary;
	private int eventID;
	private int startTime;  //4 digits: HHMM
	private int endTime;  //4 digits: HHMM
	private int duration;  //in minutes
	private String location;
	private Boolean timeDependent;
	private int score;


	public Event(int eventID, String eventSummary, int startTime, int endTime, int duration, String location, Boolean timeDependent, String type) {
		this.eventID = eventID;
		this.eventSummary = eventSummary;
		this.startTime = startTime;
		this.endTime = endTime;
		this.getDuration = duration;
		this.location = location;
		this.timeDependent = timeDependent;
		if(type.equals("want")) score = PREFERRED_SCORE;
		else if(type.equals("normal")) score = PREFERRED_SCORE;
		else score = UNPREFERRED_SCORE;
	}

	public int getStartTime() { return startTime; }

	public int getEndTime() { return endTime; }

	public int getDuration() {return duration; }

	public int getScore() { return score; }
}
