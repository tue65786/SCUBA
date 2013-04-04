/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package validationUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Dan Kauffman
 * @ Temple
 */
public class ValidateEmailAddress {

    private String convertedString = "";
    private String error = "";
    final private String EMAIL_PATTERN =
                         "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                         + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    /**
     *
     * @param val
     * @param maxlen
     * @param required
     */
    public ValidateEmailAddress(String val, int maxlen, boolean required) {
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher;

        if(val == null) {
            this.error = "Null not accepted as String Input";
            return;
        }
        if(val.length() == 0) {
            if(required) {
                this.error = "Input is required";
                return;
            }
            else {
                this.error = ""; // Empty string OK if fld not req'd.
                return;
            }
        }
        if(val.length() > maxlen) {
            this.convertedString = val.substring(0, maxlen);
            this.error = "Please shorten to [" + convertedString + "]";
            return;
        }

        matcher = pattern.matcher(val);
        if(!matcher.matches()) {
            this.error = "This is not a valid email address.";
            return;
        }

        this.convertedString = val;
        this.error = "";  // any other input is OK
    }

    /**
     *
     * @return
     */
    public String getError() {
        return this.error;
    }

    /**
     *
     * @return
     */
    public String getConvertedString() {
        return this.convertedString;
    }
}
