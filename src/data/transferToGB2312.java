package data;

import java.io.UnsupportedEncodingException;

public class transferToGB2312 {
    public static String getString(String s)
    {
        if(s!=null)
        {
            try {
                byte[] b =s.getBytes("iso-8859-1");
                s=new String(b,"GB2312");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return s;
    }
}
