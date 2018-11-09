package goodevening;

public class Event {
	private final static double UNPREFERRED_SCORE = 1;
    private final static double NORMAL_SCORE = 2;
	private final static double PREFERRED_SCORE_MIN = 0.1;
    private final static double PREFERRED_SIGHTSEEING_SCORE = 14;
	private final static String RESTAURANT_TAG = "restaurant";
	private final static String MOVIE_TAG = "movie";
	private final static String EXHIBITION_TAG = "exhibition";
	private final static String CONCERT_TAG = "concert";
	private final static String OUTDOOR_TAG = "outdoor";
	private final static int RESTAURANT_INDEX = 0;
	private final static String MOVIE_INDEX = 1;
	private final static String EXHIBITION_INDEX = 2;
	private final static String CONCERT_INDEX = 3;
	private final static String OUTDOOR_INDEX = 4;
	private String eventSummary;
	private int eventID;
	private int startTime;  //4 digits: HHMM
	private int endTime;  //4 digits: HHMM
	private int duration;  //in minutes
	private String location;
	private Boolean timeDependent;
	private String category;
	private String subCategory;
	private double score;

	public Event(int eventID, String eventSummary, int startTime, int endTime, int duration, String location, Boolean timeDependent, String category, String subCategory) {
		this.eventID = eventID;
		this.eventSummary = eventSummary;
		this.startTime = startTime;
		this.endTime = endTime;
		this.duration = duration;
		this.location = location;
		this.timeDependent = timeDependent;
		this.category = category;
		this.subCategory = subCategory;
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

	//set score based on category, subCategory, and preferences input
	public void setScore(ArrayList<String> preferences) {
		if(category.equals(RESTAURANT_TAG)) {
			if(subCategory.equals(preferences.get(RESTAURANT_INDEX)))
				score = duration * PREFERRED_SCORE_MIN;
			else score = UNPREFERRED_SCORE;
		}
		else if(category.equals(MOVIE_TAG)) {
			if(subCategory.equals(preferences.get(MOVIE_INDEX)))
				score = duration * PREFERRED_SCORE_MIN;
			else score = UNPREFERRED_SCORE;
		}
		else if(category.equals(EXHIBITION_TAG)) {
			if(preferences.get(EXHIBITION_INDEX).equals("yes"))
				score = PREFERRED_SIGHTSEEING_SCORE;
			else score = UNPREFERRED_SCORE;
		}
		else if(category.equals(CONCERT_TAG)) {
			if(preferences.get(CONCERT_INDEX).equals("yes"))
				score = duration * PREFERRED_SCORE_MIN;
			else score = UNPREFERRED_SCORE;
		}
		else if(category.equals(OUTDOOR_TAG)) {
			if(subCategory.equals(preferences.get(OUTDOOR_INDEX)))
				score = PREFERRED_SIGHTSEEING_SCORE;
			else score = UNPREFERRED_SCORE;

		}
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
