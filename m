From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 08 Mar 2003 04:12:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047067923.1226.26.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain> 
	<3E68B895.2080500@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rOCB-0002vS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 12:11:56 -0800
In-Reply-To: <3E68B895.2080500@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-03-07 at 23:19, Thomas Winischhofer wrote:
> 
> This works - perfectly, I must say.
> 
> However, the scrolling problem is still here, but I think I know the 
> reason for this:
> 
> Imagine a console of 120x40 (using the std 8x16 font), on a screen of 
> 1024x768, using ypanning.
> 
> This uses only 40*16=640 pixels vertically instead of the 768 available.
> 
> The problem is the y panning, and is kind of both console's as well as 
> the driver's fault:
> 
> When the y panning area reaches its end, it's supposed to copy the 
> screen to the beginning of this area and pan to position 0.
> 
> However, fbcon calculates p->vrows by info->var.yres_virtual / fontheight.
> 
> This disregards the fact that the visible screen area is actually larger 
> than the area console is supposed to use.

I've tested where the virtual window size is much smaller than the
physical dimensions, and I do see the glitch you mentioned.  But it's
mainly due to clear_margins().  clear_margins always erases a constant
amount (physical_height - actual height).  So if you happen to pan just
enough that there's not enough screen estate left, it will attempt to
clear past yres_virtual.  Bad for drivers that do not implement
clipping. Perhaps, block moves are involved here also, I'm not sure. 

So your patch has the correct idea, but here's a simpler one. It just
reserves enough screen estate equal to difference of physical height and
virtual height. I've tested this even using stty cols 2, and it works
okay.

NOTE:  Since we need var->yres, this time, we need to refer to info->var
instead of the adjusted var.

BTW:  I've tested moving clear_margins before panning, it still doesn't
remove the onrushing text past the virtual window height.  This would
seem to need clipping to remove that eyesore.  

If the patch doesn't apply cleanly, it should be easy enough to do so
manually.

Tony

diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-07 15:03:06.000000000 +0000
+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-07 20:06:39.000000000 +0000
@@ -1044,6 +1044,7 @@
 		vc->vc_rows = nr_rows;
 	}
 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
+	p->vrows -= info->var.yres - vc->vc_rows;
 	if ((info->var.yres % vc->vc_font.height) &&
 	    (info->var.yres_virtual % vc->vc_font.height <
 	     info->var.yres % vc->vc_font.height))
@@ -1821,8 +1822,9 @@
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
-		p->vrows = info->var.yres_virtual/fh;
 	}
+	p->vrows = info->var.yres_virtual/fh;
+	p->vrows -= (info->var.yres + (fh - 1))/fh - vc->vc_rows;
 	return 0;
 }
 
@@ -2094,6 +2096,7 @@
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 		p->vrows = info->var.yres_virtual / h;
+		p->vrows -= info->var.yres/h - vc->vc_rows;
 		if ((info->var.yres % h)
 		    && (info->var.yres_virtual % h < info->var.yres % h))
 			p->vrows--;





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
