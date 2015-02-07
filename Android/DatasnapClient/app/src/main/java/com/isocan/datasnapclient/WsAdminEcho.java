package com.isocan.datasnapclient;

import android.util.Base64;
import com.android.volley.AuthFailureError;
import com.android.volley.Response;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by isocan on 2/7/2015.
 */
public class WsAdminEcho extends JsonObjectRequest
{

    String mUserName = "admin";
    String mPassword = "admin";

    Map<String, String> headers = new HashMap<String, String>();

    public WsAdminEcho(int method, String url, JSONObject jsonRequest, Response.Listener<JSONObject> listener, Response.ErrorListener errorListener)
    {
        super(method, url, jsonRequest, listener, errorListener);

        String encodedValue = new String(Base64.encode((mUserName + ":" + mPassword).getBytes(), Base64.NO_WRAP));
        this.headers.put("Authorization", "Basic " + encodedValue);
    }

    @Override
    public Map<String, String> getHeaders() throws AuthFailureError
    {
        return headers;
    }
}
