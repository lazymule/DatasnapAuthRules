package com.isocan.datasnapclient;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;


public class MainActivity extends ActionBarActivity implements Response.Listener<JSONObject>,Response.ErrorListener
{
    String URL = "http://yourserver.net:8079/datasnap/rest/TServerMethods1/AdminEcho/ismail";

    RequestQueue mRequestQueue;

    Map<Class,String> map = new HashMap<Class,String>();

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        map.put(VolleyError.class,"Volley Hatası");
        map.put(AuthFailureError.class,"Yetki Hatası");

        try
        {
           mRequestQueue = Volley.newRequestQueue(getApplicationContext());
           WsAdminEcho request = new WsAdminEcho(Request.Method.GET,URL,null,this,this);
            mRequestQueue.add(request);
        }catch (Exception e)
        {
           Toast.makeText(this,e.getMessage(),Toast.LENGTH_LONG).show();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }



    @Override
    public void onResponse(JSONObject response)
    {
        Toast.makeText(this,"Sonuç : ".concat(response.toString()),Toast.LENGTH_LONG).show();
    }

    @Override
    public void onErrorResponse(VolleyError response)
    {
        StringBuilder message = new StringBuilder();
        message.append("Hata Türü : ").append(map.get(response.getClass())).append("\n");

        message.append("Hata Mesajı :").append(response.getMessage());
        Toast.makeText(this,message.toString(),Toast.LENGTH_LONG).show();
    }
}
