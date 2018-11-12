package goodevening;

import java.util.ArrayList;

public class Event {
	private final static double UNPREFERRED_SCORE = 1;
    private final static double NORMAL_SCORE = 2;
	private final static double PREFERRED_SCORE_MIN = 0.1;
    private final static double PREFERRED_SIGHTSEEING_SCORE = 14;
	private final static String RESTAURANT_TAG = "restaurant";
	private final static String MOVIE_TAG = "movie";
	private final static String EXHIBITION_TAG = "exhibition";
	private final static String SHOPPING_TAG = "shopping";
	private final static String SIGHTSEEING_TAG = "sightseeing";
	private final static int RESTAURANT_INDEX = 0;
	private final static int MOVIE_INDEX = 1;
	private final static int EXHIBITION_INDEX = 2;
	private final static int SHOPPING_INDEX = 3;
	private final static int SIGHTSEEING_INDEX = 4;
	private int eventID;
	private String eventSummary;
	private int startTime;  //4 digits: HHMM
	private int endTime;  //4 digits: HHMM
	private int duration;  //in minutes
	private String location;
	private boolean timeDependent;
	private String category;
	private String subCategory;
	private double score = -1;

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
		this.category = other.category;
		this.subCategory = other.subCategory;
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
		//TODO: has subcategory
		else if(category.equals(EXHIBITION_TAG)) {
			if(subCategory.equals(preferences.get(EXHIBITION_INDEX)))
				score = PREFERRED_SIGHTSEEING_SCORE;
			else score = UNPREFERRED_SCORE;
		}
		//TODO: has subcategory
		else if(category.equals(SHOPPING_TAG)) {
			if(subCategory.equals(preferences.get(SHOPPING_INDEX)))
				score = PREFERRED_SIGHTSEEING_SCORE;
			else score = UNPREFERRED_SCORE;
		}
		else if(category.equals(SIGHTSEEING_TAG)) {
			if(subCategory.equals(preferences.get(SIGHTSEEING_INDEX)))
				score = PREFERRED_SIGHTSEEING_SCORE;
			else score = UNPREFERRED_SCORE;
		}
	}

	//TODO: create getter for almost everything

	public String getSummary() { return eventSummary; }

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

	//used for responding to front end
	public String getHTMLItem() {
		String html = "<li> <div>" + eventSummary + "</div>"
					+ "<div>" + startTime + "</div>"
					+ "<div>" + endTime + "</div>"
					+ "<div>" + location + "</div>"
					+ "<div>" + category + "</div>"
					+ "<div>" + subCategory + "</div>"
					+ "</li>";
					//TODO: add <img>
		return html;
	}
}
