<%@ WebHandler Language="C#" Class="ZhuqinGetMsg" %>

using System;
using System.Web;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Globalization;
using System.Text.RegularExpressions;

public class ZhuqinGetMsg : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        String sql = "select * from txd.dbo.zqMsgForChejian";
        DataSet zqTable = creataDataset(sql);
        String json = JsonConvert.SerializeObject(zqTable.Tables[0]);
        json="{\"code\":0,\"msg\":\"\",\"count\":1000,\"data\":"+json+"}";
        context.Response.Write(json);
        
    }

    public DataSet creataDataset(String sql)
    {

        String sqlStr = System.Configuration.ConfigurationManager.ConnectionStrings["sqlconnection"].ToString();
        SqlConnection con = new SqlConnection(sqlStr);
        con.Open();
        SqlCommand comd = con.CreateCommand();
        comd.CommandText = sql;
        SqlDataAdapter adapter = new SqlDataAdapter(comd);
        DataSet mydas = new DataSet();
        adapter.Fill(mydas);
        con.Close();
        return mydas;

        adapter.Dispose();

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}