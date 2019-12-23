package ndtp.security;

import java.util.Base64;

public class KeyManager {

	private static final String randomKeyword = "ZDNhaWFnQCBzaSBlbWFuIHltIC5wc2NuIHJvZiBhZWRpIGRhYiBhIGVrYW0gdG9uIG9kIGVzYWVscCAseWVrIHRlcmNzIyBkbnVvZiBldmFoIHVveSBmSQ==";

	public static String getInitKey() {
		String result = null;
		try {
			byte[] base64decodedBytes = Base64.getDecoder().decode(randomKeyword.getBytes("UTF-8"));
			result = new String(base64decodedBytes, "UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		result = reverseString(result);
		
		return parse(result);
	}
	
	private static String reverseString(String value) {
		if(value == null) return "";
		return (new StringBuffer(value)).reverse().toString();
	}
	
	private static String parse(String value) {
		return value.substring(81, 87) + value.substring(64, 68) + value.substring(18, 24);
	}
}
