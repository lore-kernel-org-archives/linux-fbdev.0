From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Fwd: [PATCH 2.5.59] fix for fbcon.c
Date: 20 Jan 2003 16:45:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043052322.3282.41.camel@localhost.localdomain>
References: <200301191956.33826.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aXiB-0005uD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 00:55:19 -0800
In-Reply-To: <200301191956.33826.alex.kern@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-01-20 at 02:56, Alexander Kern wrote: 
[...] 
> --- linux-2.5.orig/drivers/video/console/fbcon.c	2003-01-17 16:13:53.000000000 +0100
> +++ linux/drivers/video/console/fbcon.c	2003-01-19 19:17:23.000000000 +0100
> @@ -1876,17 +1876,23 @@
>  	struct display *p = &fb_display[vc->vc_num];
>  	struct fb_info *info = p->fb_info;
>  	struct fb_var_screeninfo var = info->var;
> -	int err;
> +	int err; int x_diff, y_diff;
>  
>  	var.xres = width * vc->vc_font.width;
>  	var.yres = height * vc->vc_font.height;
>  	var.activate = FB_ACTIVATE_NOW;
> -
> +	x_diff = info->var.xres - var.xres;
> +	y_diff = info->var.yres - var.yres;
> +	if(x_diff < 0 || x_diff > vc->vc_font.width ||
> +	  (y_diff < 0 || y_diff > vc->vc_font.height)) {
> +		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
>  	err = fb_set_var(&var, info);
>  	return  (err || var.xres != info->var.xres ||
> -		 var.yres != info->var.yres) ?
> -		-EINVAL : 0;
> -	  
> +			var.yres != info->var.yres) ? -EINVAL : 0;
> +	} else {
> +		DPRINTK("prevent resize\n");
> +		return 0;
> +	}
>  }
>  
>  static int fbcon_switch(struct vc_data *vc)

Yes, that will work, only if all your console have the same window
size.  If the size of one of your console is different, then these tests
(x_diff > vc->vc_font.width || y_diff > vc->vc_font.height) will become
true each time you switch consoles, so you'll be back with a yres of
1040 instead of 1050.  The best solution is for the driver to round up
to 1050 if 1040 is not acceptable. 

Still, its much better than the old one :-).  If you don't mind, I'll
add a few things to your patch: 

a.  We do not need to activate the hardware immediately if there is a
chance of failure. 

b.  The xres/yres returned from fb_set_var() will be acceptable as long
as the value is within a fontwidth/fontheight. This should fix hardware
that only has a limited set of video modes. 

BTW, I'm also attaching a diff to fix vc_resize() in vt.c. In
vc_resize(), if con_resize() exits with an error, the new console
dimensions are not reset to the original, and memory from kmalloc() is
not freed.  

Tony 

PATCH 1: fbcon_resize 
<< begin >> 

diff -Naur linux-2.5.59/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.59/drivers/video/console/fbcon.c	2003-01-20 08:19:50.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-20 08:37:06.000000000 +0000
@@ -1870,23 +1870,35 @@
 }
 

-static int fbcon_resize(struct vc_data *vc, unsigned int width, 
-			unsigned int height)
+ static int fbcon_resize(struct vc_data *vc, unsigned int width, 
+			 unsigned int height)
 {
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_info *info = p->fb_info;
 	struct fb_var_screeninfo var = info->var;
-	int err;
-
-	var.xres = width * vc->vc_font.width;
-	var.yres = height * vc->vc_font.height;
-	var.activate = FB_ACTIVATE_NOW;
-
-	err = fb_set_var(&var, info);
-	return  (err || var.xres != info->var.xres ||
-		 var.yres != info->var.yres) ?
-		-EINVAL : 0;
-	  
+	int err; int x_diff, y_diff;
+	int fw = vc->vc_font.width;
+	int fh = vc->vc_font.height;
+
+	var.xres = width * fw;
+	var.yres = height * fh;
+	x_diff = info->var.xres - var.xres;
+	y_diff = info->var.yres - var.yres;
+	if (x_diff < 0 || x_diff > fw ||
+	    (y_diff < 0 || y_diff > fh)) {
+		var.activate = FB_ACTIVATE_TEST;
+		err = fb_set_var(&var, info);
+		if (err || width != var.xres/fw ||
+		    height != var.yres/fh)
+			return -EINVAL;
+		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
+		var.activate = FB_ACTIVATE_NOW;
+		fb_set_var(&var, info);
+		p->vrows = info->var.yres_virtual/fh;
+	} else {
+		DPRINTK("prevent resize\n");
+	}
+	return 0;
 }
 
 static int fbcon_switch(struct vc_data *vc)
<< end >> 

PATCH 2: vc_resize 

<< begin >> 

diff -Naur linux-2.5.59/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.5.59/drivers/char/vt.c	2003-01-20 08:18:11.000000000 +0000
+++ linux/drivers/char/vt.c	2003-01-20 08:17:37.000000000 +0000
@@ -732,6 +732,10 @@
 	if (new_cols == video_num_columns && new_rows == video_num_lines)
 		return 0;
 
+	err = resize_screen(currcons, new_cols, new_rows);
+	if (err)
+		return err;
+
 	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
@@ -746,9 +750,6 @@
 	video_size_row = new_row_size;
 	screenbuf_size = new_screen_size;
 
-	err = resize_screen(currcons, new_cols, new_rows);
-	if (err)
-		return err;
 
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
<< end >>



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
