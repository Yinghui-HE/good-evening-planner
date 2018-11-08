package goodevening;

public class Event {
	public final static double UNPREFERRED_SCORE = 1;
    public final static double NORMAL_SCORE = 2;
	public final static double PREFERRED_SCORE_MIN = 0.1;
    public final static double PREFERRED_SIGHTSEEING_SCORE = 14;
	private String eventSummary;
	private int eventID;
	private int startTime;  //4 digits: HHMM
	private int endTime;  //4 digits: HHMM
	private int duration;  //in minutes
	private String location;
	private Boolean timeDependent;
	private double score;


	public Event(int eventID, String eventSummary, int startTime, int endTime, int duration, String location, Boolean timeDependent, String type) {
		this.eventID = eventID;
		this.eventSummary = eventSummary;
		this.startTime = startTime;
		this.endTime = endTime;
		this.duration = duration;
		this.location = location;
		this.timeDependent = timeDependent;
		if(type.equals("want")) score = duration * PREFERRED_SCORE_MIN;
		else if(type.equals("normal")) score = NORMAL_SCORE;
		else if(type.equals("wantss")) score = PREFERRED_SIGHTSEEING_SCORE;
		else score = UNPREFERRED_SCORE;
	}
	
	public Event(Event other) {
		this.eventID = other.eventID;
		this.eventSummary = other.eventSummary;
		this.startTime = other.startTime;
		this.endTime = other.endTime;
		this.duration = other.duration;
		this.location = other.location;
		this.timeDependent = other.timeDependent;
		this.score = other.score;
	}

	public int getStartTime() { return startTime; }

	public int getEndTime() { return endTime; }

	public int getDuration() { return duration; }

	public double getScore() { return score; }

	public void setStartTime(int newStartTime) {
		if(!timeDependent) startTime = newStartTime;
	}

	public void setEndTime(int newEndTime) {
		if(!timeDependent) endTime = newEndTime;
	}


	public boolean isTimeDependent() { return timeDependent; }
}
