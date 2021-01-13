package ndtp.security;

import org.junit.jupiter.api.Test;

import ndtp.security.Crypt;

public class CryptTest {

	/**
	 * 암복호화 테스트
	 */
	@Test
	public void 암복호화() {
		System.out.println("url : " + Crypt.encrypt("jdbc:postgresql://localhost:5432/scdt"));
		// result => GvEa084OoJKPfNVpNHbfs/KHGXnmV1yqVqZU7yr5tl8d2LTIzkxBSAtvIdA39xEZ
		System.out.println("user : " + Crypt.encrypt("postgres"));
		// System.out.println("password : " + Crypt.encrypt("postgres"));
		// result => lxX28XJgkJy2XmCM3zm+rg==
		System.out.println("password : " + Crypt.encrypt("postgres"));
		// result => lxX28XJgkJy2XmCM3zm+rg==
		System.out.println("scdt : " + Crypt.encrypt("scdt"));
		// result => Ur/VVZFHGhRf1Z/I5cqhyw==
	}
}
