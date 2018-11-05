package goodevening;

public class Event {
	private String eventSummary;
	private int eventID;
	private int startTime;
	private int endTime;
	private int duration;
	private String location;
	private Boolean timeDependent;
	private int schedulingWeight;
	
	
	public Event(int eventID, String eventSummary, int startTime, int endTime, int duration, String location, Boolean timeDependent, int schedulingWeight) {
		this.eventID = eventID;
		this.eventSummary = eventSummary;
		this.startTime = startTime;
		this.endTime = endTime;
		this.getDuration = duration;
		this.location = location;
		this.timeDependent = timeDependent;
		this.schedulingWeight = schedulingWeight;
	}
	
	public int getStartTime() {}
	
	public int getEndTime() {}
	
	public int getDuration
}
