package com.org.iopts.csp.comm;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 데이터 암/복호화 해싱 처리
 */
public class CryptoUtil {
	private static String PASSWORD_HASH_SALT = "{104268329458907258984230}";
	protected static Log logger = LogFactory.getLog(CryptoUtil.class);

	// 암호화 변환 규칙(암호화알고리즘/운용모드/패딩)
	private static String transformationRule = "AES/CBC/PKCS5Padding";
	// Initialization Vector
	// ( 블록 암호의 운용 모드[Block engine modes of operation]가 CBC/OFB/CFB를 사용할 경우에는
	//   Initialization Vector[IV]를 설정해줘야한다. )
	private static String IV = "ABCDEFGHIJKLMNOP";

	/**
	 * @param message
	 * @param salt
	 * @return
	 */
	public static String hashData(String message, String salt) {
		try {
			message += salt;
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");

			return new String(new Base64().encode(messageDigest.digest(message.getBytes("UTF-8"))));
		} catch(Exception e) {
			logger.error(e.getMessage());
		}

		return null;
	}

	/**
	 * @param password
	 * @return
	 */
	public static String encryptPassword(String password) {
		//return hashData(password, PASSWORD_HASH_SALT);
		try {
			return hashData256(password, PASSWORD_HASH_SALT);
		} catch(Exception e) {
			logger.error(e.getMessage());
		}

		return null;
	}

	/**
	 * @param message
	 * @param salt
	 * @return
	 * @throws Exception
	 */
	public static String hashData256(String message, String salt)throws Exception {
		return SHA256hash( message.getBytes("UTF-8"), salt.getBytes("UTF-8") );
	}

	/**
	 * <pre>
	 * 실제 해쉬함수 적용 처리 로직
	 * </pre>
	 *
	 * @param array
	 * @param salt
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	private static String SHA256hash(byte[] array, byte[] salt) throws NoSuchAlgorithmException {
		byte[] result;
		MessageDigest m = MessageDigest.getInstance( "SHA-256" );
		m.reset();
		m.update(salt);
		result = m.digest(array);
		return asHex(result);
	}

	/**
	 * <pre>
	 * 바이트코드를 Hex 코드로 전환
	 * </pre>
	 *
	 * @param hash    해쉬코드
	 * @return
	 */
	private static String asHex(byte hash[]) {
		StringBuffer buf = new StringBuffer( hash.length * 2 );
		int i;

		for(i = 0; i < hash.length; i++) {
			if((hash[i] & 0xff) < 0x10)
				buf.append("0");

			buf.append(Long.toString(hash[i] & 0xff, 16));
		}

		return buf.toString();
	}

	/**
	 * AES 암호화 메소드
	 *
	 * @param plainText
	 * @param encryptionKey
	 * @return
	 * @throws Exception
	 */
	public static String encrypt(String plainText, String encryptionKey) throws Exception {
		// 암호화된 Hex 문자열
		String encryptedHexString = null;

		// 암호화 객체 생성
		Cipher cipher = Cipher.getInstance(transformationRule);

		// Initialization Vector 객체 생성
		IvParameterSpec ivParameterSpec = new IvParameterSpec(IV.getBytes("UTF-8"));

		// AES 알고리즘에 사용할 비밀키(SecretKey) 를 생성
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");

		// 암호화 객체 '암호화 모드'로 초기화
		cipher.init(Cipher.ENCRYPT_MODE, key, ivParameterSpec);

		// 암호화 수행
		byte[] encryptedByteArray = cipher.doFinal(plainText.getBytes("UTF-8"));
		encryptedHexString = CryptoUtil.asHex(encryptedByteArray);
		
		//logger.debug("원문 : " + plainText);
		//logger.debug("암호화된 Hex 문자열 : " + encryptedHexString);
		System.out.println("원문 : " + plainText);
		System.out.println("암호화된 Hex 문자열 : " + encryptedHexString);

		return encryptedHexString;
	}

	/**
	 * Converts an array of characters representing hexadecimal values into an array of bytes of those same values. The
	 * returned array will be half the length of the passed array, as it takes two characters to represent any given
	 * byte. An exception is thrown if the passed char array has an odd number of elements.
	 * 
	 * @param data
	 *            An array of characters containing hexadecimal digits
	 * @return A byte array containing binary data decoded from the supplied char array.
	 * @throws DecoderException
	 *             Thrown if an odd number or illegal of characters is supplied
	 */
	public static byte[] decodeHex(char[] data) { // throws DecoderException

		int len = data.length;

		if ((len & 0x01) != 0) {
		//    throw new DecoderException("Odd number of characters.");
		}

		byte[] out = new byte[len >> 1];

		// two characters form the hex value.
		for (int i = 0, j = 0; j < len; i++) {
			int f = toDigit(data[j], j) << 4;
			j++;
			f = f | toDigit(data[j], j);
			j++;
			out[i] = (byte) (f & 0xFF);
		}

		return out;
	}

	/**
	 * Converts a hexadecimal character to an integer.
	 * 
	 * @param ch
	 *            A character to convert to an integer digit
	 * @param index
	 *            The index of the character in the source
	 * @return An integer
	 * @throws DecoderException
	 *             Thrown if ch is an illegal hex character
	 */
	protected static int toDigit(char ch, int index) { // throws DecoderException
		int digit = Character.digit(ch, 16);
		if (digit == -1) {
		//    throw new DecoderException("Illegal hexadecimal character " + ch + " at index " + index);
		}
		return digit;
	}

	/**
	 * AES 복호화 메소드
	 *
	 * @param cipherText
	 * @param encryptionKey
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(String cipherText, String encryptionKey) throws Exception {
		return decrypt(CryptoUtil.decodeHex(cipherText.toCharArray()), encryptionKey);
		//return null;
	}

	/**
	 * AES 복호화 메소드
	 *
	 * @param cipherText
	 * @param encryptionKey
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(byte[] cipherText, String encryptionKey) throws Exception {
		// 암호화된 Hex 문자열
		//String cipherHexString = Hex.encodeHexString(cipherText);

		// 복호화된 텍스트
		String decryptedText = null;

		// 암호화 객체 생성
		Cipher cipher = Cipher.getInstance(transformationRule);

		// Initialization Vector 객체 생성
		IvParameterSpec ivParameterSpec = new IvParameterSpec(IV.getBytes("UTF-8"));

		// AES 알고리즘에 사용할 비밀키(SecretKey) 를 생성
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");

		// 암호화 객체 '복호화 모드'로 초기화
		cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec);

		// 복호화 수행
		byte[] decryptedByteArray = cipher.doFinal(cipherText);
		decryptedText = new String(decryptedByteArray, "UTF-8");

		//logger.debug("암호화된 Hex 문자열 : " + cipherHexString);
		//logger.debug("복호화된 텍스트 : " + decryptedText);
		//System.out.println("암호화된 Hex 문자열 : " + cipherHexString);
//		System.out.println("복호화된 텍스트 : " + decryptedText);

		return decryptedText;
	}

	/**
	 * 메인 메소드
	 *
	 * @param args
	 */
	public static void main(String[] args){

		try {
			String pwd = "happypass";

			//암호화된 salt 생성 (for DB 저장)
			//String encodedSalt ="WyT0zVk+lRLEg+hhRh0DDp9haK+3bidONhjxHix0a7Apv1v+vZnf4zwnDAK+zDtdhOIismPA3Ov7khEMJSw7xC6Ek+LBRdTjaGrbnI5bV9n1pDC+Xn7jscJTtZLxFYyCiqLaT/1zlO+Yt/QK2VYYO7spoQKR7KFiIH0cCNVkPjc=";
			//String encodedSalt = Sha256.getSalt();

			//String encodedSalt = new String(Base64.encodeBase64(Sha256.createSalt()));

			//암호화된 비밀번호 생성 (for DB 저장 및 로그인 시 비교)
			String encodedPwd = encryptPassword(pwd);

			System.out.println("[SHA256 암호화된 비밀번호]--------------------------");
			System.out.println(encodedPwd);
			System.out.println("길이 : " + encodedPwd.length());
			System.out.println("--------------------------");

			String encryptedHexString = encrypt("암호화!!!", "ipy0gt7t2adcmx5a");
			byte[] decodedByteArray = CryptoUtil.decodeHex(encryptedHexString.toCharArray());
			decrypt(decodedByteArray, "ipy0gt7t2adcmx5a");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
