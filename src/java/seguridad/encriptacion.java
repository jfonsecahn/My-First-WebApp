/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package seguridad;

import java.security.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.lang.RandomStringUtils;

public class encriptacion {

    private String hashpass = "";

    public String getHashPass(String password) throws
            NoSuchAlgorithmException {

        String plainText = password;
        MessageDigest shaAlgorithm = MessageDigest.getInstance("SHA1");
        shaAlgorithm.update(plainText.getBytes());

        byte[] digest = shaAlgorithm.digest();
        StringBuffer hexString = new StringBuffer();

        for (int i = 0; i < digest.length; i++) {
            plainText = Integer.toHexString(0xFF & digest[i]);

            if (plainText.length() < 2) {
                plainText = "0" + plainText;
            }

            hexString.append(plainText);
        }
        hashpass = hexString.toString();

        return hashpass;
    }

    public String obtener_contra() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@!#$%&";
        String password = RandomStringUtils.random(16, characters);
        String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@!#$%&])(?=\\S+$).{8,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);
        if (matcher.matches()) {
            return password;
        } else {
            return obtener_contra();
        }
    }
}
