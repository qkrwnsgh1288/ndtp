package ndtp.security;

import org.junit.jupiter.api.Test;

import ndtp.security.Crypt;

public class CryptTest {

	/**
	 * 암복호화 테스트
	 */
	@Test
	public void 암복호화() {
		System.out.println("url : " + Crypt.encrypt("jdbc:postgresql://192.168.200.10:5432/ndtp"));
		System.out.println("user : " + Crypt.encrypt("postgres"));
		System.out.println("password : " + Crypt.encrypt("qweasd12"));
		
		System.out.println(Crypt.decrypt("sYJU8UaMdyaSX5Oo8BkIOpJQiKY1K0QJsRnwZ1A9ialfnBs7vBjQ1l7bQevNEDNt"));
	}
}
