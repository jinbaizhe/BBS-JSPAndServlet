package data;
import java.util.Date;
import java.text.SimpleDateFormat;
public class getTime {
	

	public  String getCurrentTime(){
		String timeRightNow; 
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		timeRightNow = time.format(now);
		return timeRightNow;
	}
}
