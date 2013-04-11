package SQL;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Formats various data types. Most methods wrap formatted data with an HTML <td> tag. When wrapping
 * in <td> tag, substitute "&nbsp;" (HTML non-breaking space) for empty string. If this was not
 * done, the cell in the HTML table will not show its border and usually would not look right.
 */
public class FormatUtils {

    /**
     *
     * @param o
     * @param nullValue < p/>
     * <p/>
     * @return
     */
    public static String coalesce(Object o, String nullValue) {
        if(o != null && !o.toString().equals("")) {
            return ((String) o);
        }
        else {
            return nullValue;
        }
    }

    // DecimalFormat percentFormat = new DecimalFormat("%###.##");
    // Turns a date into a nicely formatted String.
    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatDate(String css, Object obj) {
        String out = "";
        if(obj == null) {
            return out;
        }
        try {
            java.util.Date dateval = (java.util.Date) obj;

            SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
            dateformat.setLenient(false);
            out = dateformat.format(dateval);
        }
        catch (Exception e) {
            out = "bad date in FormatUtils.formatDate: " + obj.toString() + " error: " + e.getMessage();
        }
        return out;
    } // formatDate

     public static String formatDateNoHTML(Object obj) {
        if (obj == null) {
            return "";
        }
        String out = "";
        try {
            java.util.Date dateval = (java.util.Date) obj;
            if (dateval != null) {
                SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
                dateformat.setLenient(false);
                out = dateformat.format(dateval);
            }
        } catch (Exception e) {
            out = "bad date in FormatUtils.formatDateNoHTML: " + obj.toString() + " error: " + e.getMessage();
        }
        return out;
    } // formatDate
    
    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatDateTd(String css, Object obj) {
        String out = "<td class=\"" + css + "\"" + "style='text-align:center'>";
        String strDate = formatDate(css, obj);
        if(strDate.length() == 0) {
            // if you don't put a "non-breaking space" in an empty td/cell, 
            // the cell's border doesn't show !
            out += "&nbsp;";
        }
        else {
            out += strDate;
        }
        out += "</td>";
        return out;
    } // formatDateTd

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatDollar(String css, Object obj) {
        // null gets converted to empty string
        String out = "";
        if(obj == null) {
            return out;
        }
        BigDecimal bd = (BigDecimal) obj;
        try {
            DecimalFormat intFormat = new DecimalFormat("$###,###,###,##0.00");
            out += intFormat.format(bd);
        }
        catch (Exception e) {
            out += "bad Dollar Amount in FormatUtils:" + obj.toString() + " Error:" + e.getMessage();
        }
        return out;
    } // formatDollar

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatDollarTd(String css, Object obj) {
        String out = "<td class=\"" + css + "\"" + "style='text-align:right'>";
        String strDollarAmt = formatDollar(css, obj);
        if(strDollarAmt.length() == 0) {
            // if you don't put a "non-breaking space" in an empty td/cell, 
            // the cell's border doesn't show !
            out += "&nbsp;";
        }
        else {
            out += strDollarAmt;
        }
        out += "</td>";
        return out;
    } // formatDollarTd

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatInteger(String css, Object obj) {
        String out = "";
        if(obj == null) {
            return out;
        }
        if(obj.getClass().getName().contains("Long")) {
            obj = Integer.parseInt(obj.toString());
        }
        try {
            Integer ival = (Integer) obj;
            DecimalFormat intFormat = new DecimalFormat("###,###,###,##0");
            out += intFormat.format(ival);
        }
        catch (Exception e) {
            out += "bad Integer in FormatUtils:" + obj.toString() + " Error:" + e.getMessage();
        }

        return out;
    } // formatInteger

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatIntegerTd(String css, Object obj) {
        String out = "<td class=\"" + css + "\"" + " style='text-align:right'>";
        String strInteger = coalesce(formatInteger(css, obj), "--");
        if(strInteger.length() == 0) {
            // if you don't put a "non-breaking space" in an empty td/cell, 
            // the cell's border doesn't show !
            out += "&nbsp;";
        }
        else {
            out += strInteger;
        }
        out += "</td>";
        return out;
    } // formatIntegerTd

    // this is not really formatting, but just converting to string type.
    /**
     *
     * @param css
     * @param obj
     * @param rules < p/>
     * <p/>
     * @return
     */
    public static String formatString(String css, Object obj, int rules) {
        if(obj == null) {
            return "";
        }
        switch (rules) {
            case 1: //a location
                return "<a id=\"" + (String) obj + "\" >" + (String) obj + "</a>";
            case 2: //link to location
                return "<a href=\"./other.jsp#" + (String) obj + "\" >" + (String) obj + "</a>";

            default:
                return ((String) obj);
        }
    }

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatString(String css, Object obj) {
        Pattern pattern;
        Matcher matcher;
        if(obj == null) {
            return "";
        }
        String EMAIL_PATTERN =
               "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
               + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        pattern = Pattern.compile(EMAIL_PATTERN);
        matcher = pattern.matcher((String) obj);

        if(matcher.matches()) {
            return new String("<a href=\"mailto:" + (String) obj + "\" >" + (String) obj + "</a>");
        }
        else {
            return (String) obj;
        }
    } // formatString

    /**
     *
     * @param css
     * @param obj
     * @param rules < p/>
     * <p/>
     * @return
     */
    public static String formatStringTd(String css, Object obj, int rules) {
        String out = "<td class=\"" + css + "\"" + " style='text-align:left'>";
        String str = coalesce(formatString(css, obj, rules), "--");
        out += str;

        out += "</td>";
        return out;
    }

    /**
     *
     * @param css
     * @param obj < p/>
     * <p/>
     * @return
     */
    public static String formatStringTd(String css, Object obj) {
        String out = "<td class=\"" + css + "\"" + " style='text-align:left'>";
        String str = coalesce(formatString(css, obj), "--");
        if(str.length() == 0) {
            out += "&nbsp;";
        }
        else {
            out += str;
        }
        out += "</td>";
        return out;
    } // formatString

    /**
     *
     * @param css
     * @param o   < p/>
     * <p/>
     * @return
     */
    public static String objectToString(String css, Object o) {
        if(o == null) {
            return "";
        }
        try {
            return o.toString();
        }
        catch (Exception e) {
            return "Exception converting object to string FormatUtils.objectToString(): " + e.getMessage();
        }
    }
} // FormatUtils class