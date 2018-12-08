<%@ WebHandler Language="C#" Class="Passkey" %>

using System;
using System.Web;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Globalization;
using System.Text.RegularExpressions;

public class Passkey : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String zqmsgaccount = context.Request["zqmsgaccount"].ToString();
        String zqmsgkey = context.Request["zqmsgkey"].ToString();
        context.Response.ContentType = "text/plain";
        String sqlaccount = "select worknum from txd.dbo.passkey where priority=20";
        String sqlpass = "select pass from txd.dbo.passkey where priority=20";
        DataSet accountdata=creataDataset(sqlaccount);
        DataSet passdata = creataDataset(sqlpass);
        String accountdatastr = accountdata.Tables[0].Rows[0][0].ToString();
        String passdatastr = passdata.Tables[0].Rows[0][0].ToString();
        if (zqmsgaccount == accountdatastr && zqmsgkey == passdatastr)        
        context.Response.Write(1);
        else
            context.Response.Write(0);
        
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
        //return adapter;
        adapter.Dispose();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
}