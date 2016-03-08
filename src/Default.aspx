<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Project/Site.master" AutoEventWireup="true" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        RssData.DataFile = "http://feeds.movieweb.com/movieweb_movienews";
    }

</script>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            var title;
            var year;
            var imdbId;
            var poster;
            var rtMovieid;

            //Call to the handler 'Handler.ashx'
            //The 'Handler.ashx' make sends requests to the RottenTomatoes API.
            //This is to receive the list of Upcoming Movies
            $.post('Handler.ashx', { "category": "UPC", "page_limit": "5" }, function (data) {

                var UpcomingMovies = data.movies;
                $.each(UpcomingMovies, function (index, movie) {
                    getMovieData(movie);
                    displayMovieData(1);
                });
            });



            //Call to the handler 'Handler.ashx'
            //The 'Handler.ashx' make sends requests to the RottenTomatoes API.
            //This is to receive the list of In theatre Movies
            $.post('Handler.ashx', { "category": "ITM", "page_limit": "5" }, function (data) {

                var UpcomingMovies = data.movies;
                $.each(UpcomingMovies, function (index, movie) {
                    getMovieData(movie);
                    displayMovieData(2);
                });
            });
        });



        //Function to get the values of different attributes from the movie object
        function getMovieData(movie) {
            rtMovieid = movie.id;
            if (movie.alternate_ids && movie.alternate_ids.imdb) {
                imdbId = movie.alternate_ids.imdb;
            }
            else {
                alert("Sorry Movie cannot Be Found");
            }
            title = movie.title;
            year = movie.year;


            if (movie.posters.thumbnail && movie.posters) {
                poster = movie.posters.original;
            }
            else {
                poster = "../images/imageNA.jpg"
            }
        }


        //Function to create the HTML DOM Elements
        function displayMovieData(i) {

            movieItemStartHtml = "<div class='item'>";

            posterHtml = "<div class='image'><a class='highlightit' Target='blank' href = '../Project/MovieInformation.aspx?rtmovieid=" + rtMovieid + "&imdbid=" + imdbId + "' title = '" + title + "'>" +
       "<img src= '" + poster + "' alt = '" + title + "'title = '" + title + "' width='100'/></a></div>";

            movieInfoStartHtml = "<div class='info'>";
            titleHtml = "<h4>" + title + "</h4>";

            yearHtml = "<p class='release'><strong>Released</strong>:" + year + "</p>";

            movieInfoEndHtml = "</div><div style='clear: both; '/></div>";

            if (i == 1)
                $("#movies2").append(movieItemStartHtml + posterHtml + movieInfoStartHtml + titleHtml + yearHtml + movieInfoEndHtml);
            else
                $("#upcomingmovies").append(movieItemStartHtml + posterHtml + movieInfoStartHtml + titleHtml + yearHtml + movieInfoEndHtml);
        }
    </script>
    <div id="movies2">
        <h2>
            UPCOMING MOVIES</h2>
        <br />
        <br />
    </div>
    <div id="officialOuter">
        <br />
        <asp:XmlDataSource ID="RssData" CacheDuration="600" runat="server" XPath="/rss/channel/item[position()&lt;=12]">
        </asp:XmlDataSource>
        <asp:DataList ID="DataList1" runat="server" DataSourceID="RssData" CellPadding="0"
            CellSpacing="0" HorizontalAlign="Center" Style="border-collapse: collapse; background-color: #F5F5F4;
            background: -moz-linear-gradient(bottom, #E8e8e8 0%, #F2F2F1 50%); background: -ms-linear-gradient(bottom, #E8e8e8 0%, #F2F2F1 50%);
            background: -webkit-linear-gradient(bottom, #E8e8e8 0%, #F2F2F1 50%); background: linear-gradient(bottom, #E8e8e8 0%, #F2F2F1 50%);
            border: 1px solid #F6F6F5; -moz-border-radius: 12px; -ms-border-radius: 12px;
            -webkit-border-radius: 12px; border-radius: 12px; -moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.4);
            -ms-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.4); -webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.4);
            box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.4); font-family: Verdana, Arial, sans-serif;">
            <FooterStyle ForeColor="Black" />
            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" />
            <ItemStyle ForeColor="Black" />
            <HeaderTemplate>
                <center>
                    <h1 style="text-align: center; font: Verdana, Arial, sans-serif; color: Gray;">
                        Latest Movie Buzz</h1>
                    <br />
                    <br />
                </center>
            </HeaderTemplate>
            <ItemTemplate>
                <div class="link" style="padding: 0 20px 0 20px">
                    <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" Text='<%#XPath("title")%>'
                        NavigateUrl='<%#XPath("link")%>' Target="_blank">
                    </asp:HyperLink></div>
                <p style="padding: 0 20px 0 20px">
                    <%#XPath("description")%></p>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <div class="link" style="padding: 0 20px 0 20px">
                    <asp:HyperLink ID="hyperlink1" runat="server" ForeColor="Blue" Text='<%#XPath("title")%>'
                        NavigateUrl='<%#XPath("link")%>' Target="_blank">
                    </asp:HyperLink></div>
                <p style="padding: 0 20px 0 20px">
                    <%#XPath("description")%></p>
            </AlternatingItemTemplate>
            <SelectedItemStyle BackColor="#9471DE" Font-Bold="True" ForeColor="BurlyWood" />
        </asp:DataList>
    </div>
    <div id="upcomingmovies">
        <h2>
            IN THEATRES</h2>
        <br />
        <br />
    </div>
</asp:Content>
