package com.org.iopts.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ScanUtil {
	private static final Logger logger = LoggerFactory.getLogger(ScanUtil.class);

	public String times(String date) {

		String time_group = date.substring(date.length() - 2, date.length());
		
		int index = 0;
		
		if (time_group.equals("AM")) {
			index = date.indexOf(" AM");
			date = date.substring(0, index);
		} else if (time_group.equals("PM")) {
			index = date.indexOf(" PM");
			date = date.substring(0, index);
			String[] splits = date.split(":");

			int hour = Integer.parseInt(splits[0]);
			hour += 12;
			date = hour + ":" + splits[1];
		}
		return date;
	}
	
	public int times_second(String date) {
		int second_time = 0;
		String[] splits = date.split(":");
		int hour = Integer.parseInt(splits[0]);
		int min = Integer.parseInt(splits[1]);
		second_time = ((hour*60*60)+(min*60));
		
		return second_time;
	}

}
