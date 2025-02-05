package day;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateUtils {
    public static int daysUntilPresent(LocalDate fromDate) {
        LocalDate presentDate = LocalDate.now();
        return (int) ChronoUnit.DAYS.between(fromDate, presentDate);
    }
}
