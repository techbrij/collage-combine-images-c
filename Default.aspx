<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <style type="text/css">
        #collage
        {
           
            background-position: center top;
            background-repeat: no-repeat;          
            
        }
        .formContainer
        {
            padding-top:50px;
        }
        .formBox
        {
            background: linear-gradient(#FDFDFE, #EBEEF3) repeat scroll 0 0 #F6F7F8;
    border-color: #E9EAED;
    border-radius: 5px 5px 5px 5px;
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.8);
    margin: 20px auto;    
    width: 488px;
    text-align:center;
    padding:20px;
        }
    </style>     
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <header>


    </header>
        <div id="collage">
            <div class="formContainer">
            <div class="formBox">
                <h1>Welcome to TechBrij.com</h1>
                <p>
                    An example to create Facebook home page like collage in ASP.NET.
                </p>

            </div>
                </div>
        </div>
        <footer></footer>

        <script>
            $(function () {
                var width = $(window).width(), 
                    height = $(window).height(),
                    imgWidth = parseInt(width * 1.2,10),
                    imgHeight = parseInt(height * 0.7,10);
                if (width > 600) {
                    var collage = $('#collage');
                    collage.css('background-image', 'url("bgimage.ashx?w=' + imgWidth + '&h=' + imgHeight + '")');
                    collage.css({ 'height': imgHeight });
                }
            })

        </script>


    </div>
    </form>
</body>
</html>
