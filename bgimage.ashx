<%@ WebHandler Language="C#" Class="bgimage" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.Linq;

/// <summary>
/// Created By: TechBrij.com
/// Object: To create facebook home page like collage
/// </summary>
public class bgimage : IHttpHandler {

    private int imageWidth = 100, imageHeight = 100, maxWidth = 1000, maxHeight = 600,borderSize=1;

    
    public void ProcessRequest (HttpContext context) {
        
         context.Response.ContentType = "image/jpg";    
        
        //Set maxwidth and maxheight
        if (!String.IsNullOrEmpty(context.Request.QueryString["w"]))
        {
            maxWidth = Convert.ToInt32(context.Request.QueryString["w"]);
        }
        if (!String.IsNullOrEmpty(context.Request.QueryString["h"]))
        {
            maxHeight = Convert.ToInt32(context.Request.QueryString["h"]);
        }

        int rows =maxHeight / (imageHeight+2*borderSize); 
        int cols = maxWidth / (imageWidth+2*borderSize);    
        
        
        int total = rows * cols;
        maxWidth = cols * (imageWidth+2*borderSize);
        maxHeight = rows * (imageHeight+2*borderSize);
         
        using (Bitmap img = new Bitmap(maxWidth,maxHeight))
        {           
            List<String> listImg = GetProfileImages(total);
            
             //In case no sufficient images, repeat images 
            total = listImg.Count;


            int row, col,x=0,y=0;
            using (Graphics g = Graphics.FromImage(img))
            {
                using (Pen pen = new Pen(Color.White, borderSize))
                {

                    for (row = 0; row < rows; row++)
                    {

                        for (col = 0; col < cols; col++)
                        {
                            x = col * (imageWidth + borderSize * 2);
                            y = row * (imageHeight + borderSize * 2);


                            using (Image imgtemp = Image.FromFile(HttpContext.Current.Server.MapPath("~/Images/profile/") + listImg[(row * cols + col) % total]))
                            {
                                g.DrawImage(imgtemp, x + borderSize, y + borderSize, imageWidth, imageHeight);
                            }

                            //pen.Alignment = System.Drawing.Drawing2D.PenAlignment.Inset;
                            g.DrawRectangle(pen, x, y, imageWidth + 2 * borderSize - 1, imageHeight + 2 * borderSize - 1);
                        }
                    }
                }
                //Gradient effect
                if (cols > 3)
                {
                    // Create back box brush
                    Rectangle rect = new Rectangle(0, 0, imageWidth * 2, maxHeight);
                    //left side gradient
                    using (LinearGradientBrush lgBrush = new LinearGradientBrush(rect, Color.White, Color.Transparent, LinearGradientMode.Horizontal))
                    {
                        g.FillRectangle(lgBrush, rect);
                    }
                    //Right side gradient
                    rect = new Rectangle(maxWidth - imageWidth * 2, 0, imageWidth * 2, maxHeight);
                    using (LinearGradientBrush lgBrush = new LinearGradientBrush(rect, Color.Transparent, Color.White, LinearGradientMode.Horizontal))
                    {
                        g.FillRectangle(lgBrush, rect);
                    }
                }
            }
            img.Save(context.Response.OutputStream, ImageFormat.Jpeg);
        }
    }
    /// <summary>
    /// To get image names from database
    /// </summary>
    /// <param name="max"></param>
    /// <returns></returns>
    List<String> GetProfileImages(int max) {
         List<String> listImg;
        
        using (MyDatabaseEntities context = new MyDatabaseEntities()) {
            listImg = context.ProfileInfoes
                .OrderBy(x => Guid.NewGuid())
                .Take(max)
                .Select(x => new { x.ImageGuid, x.ImageType }).ToList()
                .Select(x=>x.ImageGuid + "."+ x.ImageType).ToList();        
        }
        return listImg;
    
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}