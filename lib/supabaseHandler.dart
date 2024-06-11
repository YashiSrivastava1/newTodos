import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupabaseHandler {
  static String supabaseURL = "https://dleacljqcqvuslaonrss.supabase.co";
  static String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsZWFjbGpxY3F2dXNsYW9ucnNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgwMTQ2MTQsImV4cCI6MjAzMzU5MDYxNH0.clQC1969PG-EKVCj3517iSqZ9ysJzxldqYICaXE5Q5M";

  final client = SupabaseClient(supabaseURL, supabaseKey);
  addData(String taskValue, bool statusValue) async {
    var response = client
        .from("todoTable")
        .insert({"task": taskValue, "status": statusValue});
    //.execute();
    print(response);
  }

  readData() async {
    var response =
        await client.from("todoTable").select().order('task', ascending: true);
    //.execute();
    print(response);
    // final dataList = response.data as List;
    // return dataList;
  }

  updateData(int id, bool statusValue) {
    var response =
        client.from("todoTable").update({"status": statusValue}).eq("id", id);
    //.execute();
    print(response);
  }

  deleteData(int id) {
    var response = client.from("todoTable").delete().eq('id', id);
    //.execute();
    print(response);
  }
}
