package o.h.hadidy.image_sample;

import android.annotation.SuppressLint;
import android.app.WallpaperManager;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.Nullable;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.util.GeneratedPluginRegister;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegister.registerGeneratedPlugins(getFlutterEngine());
        GeneratedPluginRegistrant.registerWith(getFlutterEngine());

        new MethodChannel(getFlutterEngine().getDartExecutor(),"o.h.hadidy").setMethodCallHandler((call, result) -> {
            switch (call.method){
                case "setBackground":
                    new Handler(Looper.getMainLooper()).post(new Runnable() {
                        @Override
                        public void run() {
                            setBackground(call.arguments.toString(),result);

                        }
                    });
                    break;
                case "openAddress":
                    openAddress(call.arguments.toString());
                    break;
            }
        });
    }

    public void setBackground(String bmap, MethodChannel.Result call){
        new DownloadImage(bmap,call).execute();
    }

    public void openAddress(String address){
        Log.i("tagggged", "openAddress: ");
        Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse(address));
        startActivity(i);
    }

    // download and set image to background
    class DownloadImage extends AsyncTask<String,Void,Boolean> {
        String imageAddress;
        MethodChannel.Result call;

        public DownloadImage(String imageAddress,MethodChannel.Result call) {
            this.imageAddress = imageAddress;
            this.call = call;
        }

        @SuppressLint("WrongThread")
        @Override
        protected Boolean doInBackground(String... strings) {
            try {
                HttpURLConnection con = (HttpURLConnection) ( new URL(imageAddress)).openConnection();
                con.setDoInput(true);
                con.connect();

                InputStream is = con.getInputStream();
                Bitmap myBitmap = BitmapFactory.decodeStream(is);
                WallpaperManager m=WallpaperManager.getInstance(MainActivity.this);
                m.setBitmap(myBitmap);
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
            return false;
        }

        @Override
        protected void onPostExecute(Boolean aBoolean) {
            Log.i("TAG", "onPreExecute: ended");
            call.success(200);
            super.onPostExecute(aBoolean);
        }
    }
}
