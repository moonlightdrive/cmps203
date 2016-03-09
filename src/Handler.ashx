<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Net;

public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {

            string page_limit;
            string category = context.Request["category"];
            string type = "";

            page_limit = context.Request["page_limit"];

            if (category == "BOM")
            {

                type = "box_office.json?";

            }

            else if (category == "ITM")
            {


                type = "in_theaters.json?";
            }
            else if (category == "OM")
            {
                type = "opening.json?";

            }
            else
            {
                type = "upcoming.json?";
            }
            string completeURL = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/" + type + "page_limit=" + page_limit + "&page=1&country=us&apikey=7n5kqnmyttvx2q5eyznffy55";
            WebClient rottenTomatoAPI = new WebClient();
            string response = rottenTomatoAPI.DownloadString(completeURL);
            response = response.Trim(new char[] { '\n', '\r' });
            context.Response.ContentType = "application/json";
            context.Response.Write(response);
        }
        catch (Exception e)
        {
            context.Response.Write(e.Message);
        }




    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}