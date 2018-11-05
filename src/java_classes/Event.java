package java_classes;

public class Event {
	private String eventSummary;
	private int eventID;
	private String startTime;
	private String endTime;
	private String location;
	private Boolean timeDependent;
	private int schedulingWeight;
	
	
	public Event(int eventID, String eventSummary, String startTime, String endTime, String location, Boolean timeDependent, int schedulingWeight) {
		this.eventID = eventID;
		this.eventSummary = eventSummary;
		this.startTime = startTime;
		this.endTime = endTime;
		this.location = location;
		this.timeDependent = timeDependent;
		this.schedulingWeight = schedulingWeight;
	}
}
