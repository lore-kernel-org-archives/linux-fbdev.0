From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Fwd: [PATCH 2.5.59] fix for fbcon.c
Date: 17 Feb 2003 19:33:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045480744.1324.7.camel@localhost.localdomain>
References: <200301191956.33826.alex.kern@gmx.de> 
	<1043052322.3282.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kjWw-0000no-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 03:33:51 -0800
In-Reply-To: <1043052322.3282.41.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-01-20 at 16:45, Antonino Daplas wrote:
> On Mon, 2003-01-20 at 02:56, Alexander Kern wrote: 
> 
> Yes, that will work, only if all your console have the same window
> size.  If the size of one of your console is different, then these tests
> (x_diff > vc->vc_font.width || y_diff > vc->vc_font.height) will become
> true each time you switch consoles, so you'll be back with a yres of
> 1040 instead of 1050.  The best solution is for the driver to round up
> to 1050 if 1040 is not acceptable. 
> 
> Still, its much better than the old one :-).  If you don't mind, I'll
> add a few things to your patch: 
> 
> a.  We do not need to activate the hardware immediately if there is a
> chance of failure. 
> 
> b.  The xres/yres returned from fb_set_var() will be acceptable as long
> as the value is within a fontwidth/fontheight. This should fix hardware
> that only has a limited set of video modes. 
> 

Here's an incremental patch (linux-2.5.61 + James' latest fbdev.diff) 

1. adjust display->vrows unconditionally during fbcon_resize().  This
should prevent console corruption when var->yres_virtual was changed
behind the back of the console, ie using fbset.

2. call fbcon_resize() as early as possible during fbcon_switch().

Tony

diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-16 21:01:01.000000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-16 22:20:31.000000000 +0000
@@ -1879,8 +1879,8 @@
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
-		p->vrows = info->var.yres_virtual/fh;
 	}
+	p->vrows = info->var.yres_virtual/fh;
 	return 0;
 }
 
@@ -1915,6 +1915,9 @@
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
+
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -1933,7 +1936,6 @@
 
 	info->currcon = unit;
 	
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	update_var(unit, info);
 	fbcon_set_palette(vc, color_table); 	
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
