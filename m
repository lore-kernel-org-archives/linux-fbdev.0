From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 07 Mar 2003 22:01:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047045694.1310.6.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>
	<3E688BDA.8080506@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rIPH-000197-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 06:01:03 -0800
In-Reply-To: <3E688BDA.8080506@winischhofer.net>
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

On Fri, 2003-03-07 at 20:08, Thomas Winischhofer wrote:
> 
> 
> However, there is still (at least) one problem within the console layer.
> 
> With my patch, I can now have a console of for instance 128x20 
> characters, on a 1024x768 screen. Scrolling mostly works, but sometimes 
> console seems to forget to pan. I can't reproduce this on purpose, but 
> printing eg. a directory with ls works in 90% of the cases (=scrolls 
> correctly), but prints text beyond the current amount of rows in the 
> remaining 10% of the cases. If I press enter until the last line of the 
> console is on the very bottom of the 1024x768 screen, then it remembers 
> its amount of rows and pans correctly.
>

Try this patch.  The fbcon_resize test is more liberal and it now correctly
updates p->vrows and scroll_phys_max (for panning glitches).

Tony


diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-06 01:29:29.000000000 +0000
+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-07 13:54:04.000000000 +0000
@@ -580,8 +580,8 @@
 	struct fb_info *info = p->fb_info;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
-	unsigned int rw = info->var.xres % cw;
-	unsigned int bh = info->var.yres % ch;
+	unsigned int rw = info->var.xres - (cw * vc->vc_cols);
+	unsigned int bh = info->var.yres - (ch * vc->vc_rows);
 	unsigned int rs = info->var.xres - rw;
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
@@ -1815,14 +1815,14 @@
 	   (y_diff < 0 || y_diff > fh)) {
 		var.activate = FB_ACTIVATE_TEST;
 		err = fb_set_var(&var, info);
-		if (err || width != var.xres/fw ||
-		    height != var.yres/fh)
+		if (err || width > var.xres/fw ||
+		    height > var.yres/fh)
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
-		p->vrows = info->var.yres_virtual/fh;
 	}
+	p->vrows = info->var.yres_virtual/fh;
 	return 0;
 }
 
@@ -1857,6 +1857,7 @@
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -1875,7 +1876,6 @@
 
 	info->currcon = unit;
 	
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	update_var(unit, info);
 	fbcon_set_palette(vc, color_table); 	
 




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
