From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 01:19:15 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404221010080.23920@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIGJp-00044I-Hh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:19:25 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIGJo-0007sc-DV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:19:25 -0700
In-Reply-To: <Pine.GSO.4.58.0404221010080.23920@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Okay. This is my first attempt to address this problem. There is not test 
for accelerated copyarea or image drawing as we lack the flag. I haven't 
figured where to put it yet. We have 3 choices.


fb_var_screeninfo
fb_fix_screeninfo
fb_info


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-04-26 14:49:24.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-04-25 13:44:51.000000000 -0700
@@ -605,10 +605,6 @@
 	/* on which frame buffer will we open this console? */
 	info = registered_fb[(int) con2fb_map[unit]];
 	
-	if (info->var.accel_flags)
-		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
-	else
-		fb_display[unit].scrollmode = SCROLL_YREDRAW;
 	fbcon_set_display(vc, init, !init);
 }
 
@@ -622,21 +618,19 @@
 static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-
 	int m;
-	if (p->scrollmode & __SCROLL_YFIXED)
-		return;
+	
 	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
 	    divides(vc->vc_font.height, info->var.yres_virtual))
-		m = __SCROLL_YWRAP;
+		m = SCROLL_YWRAP;
 	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
 		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
-		m = __SCROLL_YPAN;
-	else if (p->scrollmode & __SCROLL_YNOMOVE)
-		m = __SCROLL_YREDRAW;
+		m = SCROLL_YPAN;
+	if (info->fix.accel == FB_ACCEL_NONE)
+		m = SCROLL_YREDRAW;
 	else
-		m = __SCROLL_YMOVE;
-	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
+		m = SCROLL_YMOVE;
+	p->scrollmode = (p->scrollmode & ~SCROLL_YMASK) | m;
 }
 
 static void fbcon_set_display(struct vc_data *vc, int init, int logo)
@@ -1322,7 +1316,7 @@
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	int scroll_partial = !(p->scrollmode & __SCROLL_YNOPARTIAL);
+	int scroll_partial = !(p->scrollmode & SCROLL_YNOPARTIAL);
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return 0;
@@ -1346,15 +1340,15 @@
 			fbcon_softback_note(vc, t, count);
 		if (logo_shown >= 0)
 			goto redraw_up;
-		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		switch (p->scrollmode & SCROLL_YMASK) {
+		case SCROLL_YMOVE:
 			accel_bmove(vc, info, t + count, 0, t, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, b - count, 0, count,
 					 vc->vc_cols);
 			break;
 
-		case __SCROLL_YWRAP:
+		case SCROLL_YWRAP:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (t > 0)
 					fbcon_bmove(vc, 0, 0, count, 0, t,
@@ -1364,7 +1358,7 @@
 					fbcon_bmove(vc, b - count, 0, b, 0,
 						    vc->vc_rows - b,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
+			} else if (p->scrollmode & SCROLL_YREDRAW)
 				goto redraw_up;
 			else
 				fbcon_bmove(vc, t + count, 0, t, 0,
@@ -1372,7 +1366,7 @@
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YPAN:
+		case SCROLL_YPAN:
 			if ((p->yscroll + count <=
 			     2 * (p->vrows - vc->vc_rows))
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
@@ -1387,7 +1381,7 @@
 					fbcon_bmove(vc, b - count, 0, b, 0,
 						    vc->vc_rows - b,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
+			} else if (p->scrollmode & SCROLL_YREDRAW)
 				goto redraw_up;
 			else
 				fbcon_bmove(vc, t + count, 0, t, 0,
@@ -1395,7 +1389,7 @@
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YREDRAW:
+		case SCROLL_YREDRAW:
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
@@ -1413,14 +1407,14 @@
 	case SM_DOWN:
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
-		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		switch (p->scrollmode & SCROLL_YMASK) {
+		case SCROLL_YMOVE:
 			accel_bmove(vc, info, t, 0, t + count, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YWRAP:
+		case SCROLL_YWRAP:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (vc->vc_rows - b > 0)
 					fbcon_bmove(vc, b, 0, b - count, 0,
@@ -1430,7 +1424,7 @@
 				if (t > 0)
 					fbcon_bmove(vc, count, 0, 0, 0, t,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
+			} else if (p->scrollmode & SCROLL_YREDRAW)
 				goto redraw_down;
 			else
 				fbcon_bmove(vc, t, 0, t + count, 0,
@@ -1438,7 +1432,7 @@
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YPAN:
+		case SCROLL_YPAN:
 			if ((count - p->yscroll <= p->vrows - vc->vc_rows)
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
 				|| (scroll_partial
@@ -1452,7 +1446,7 @@
 				if (t > 0)
 					fbcon_bmove(vc, count, 0, 0, 0, t,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
+			} else if (p->scrollmode & SCROLL_YREDRAW)
 				goto redraw_down;
 			else
 				fbcon_bmove(vc, t, 0, t + count, 0,
@@ -1460,7 +1454,7 @@
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YREDRAW:
+		case SCROLL_YREDRAW:
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
@@ -1604,11 +1598,11 @@
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
         fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
-	switch (p->scrollmode & __SCROLL_YMASK) {
-	case __SCROLL_YWRAP:
+	switch (p->scrollmode & SCROLL_YMASK) {
+	case SCROLL_YWRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
 		break;
-	case __SCROLL_YPAN:
+	case SCROLL_YPAN:
 		scrollback_phys_max = p->vrows - 2 * vc->vc_rows;
 		if (scrollback_phys_max < 0)
 			scrollback_phys_max = 0;
@@ -2191,11 +2185,11 @@
 
 	offset = p->yscroll - scrollback_current;
 	limit = p->vrows;
-	switch (p->scrollmode && __SCROLL_YMASK) {
-	case __SCROLL_YWRAP:
+	switch (p->scrollmode && SCROLL_YMASK) {
+	case SCROLL_YWRAP:
 		info->var.vmode |= FB_VMODE_YWRAP;
 		break;
-	case __SCROLL_YPAN:
+	case SCROLL_YPAN:
 		limit -= vc->vc_rows;
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 		break;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.h fbdev-2.6/drivers/video/console/fbcon.h
--- linus-2.6/drivers/video/console/fbcon.h	2004-04-26 14:49:24.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.h	2004-04-25 13:45:51.000000000 -0700
@@ -69,39 +69,12 @@
      */
      
 /* Internal flags */
-#define __SCROLL_YPAN		0x001
-#define __SCROLL_YWRAP		0x002
-#define __SCROLL_YMOVE		0x003
-#define __SCROLL_YREDRAW	0x004
-#define __SCROLL_YMASK		0x00f
-#define __SCROLL_YFIXED		0x010
-#define __SCROLL_YNOMOVE	0x020
-#define __SCROLL_YPANREDRAW	0x040
-#define __SCROLL_YNOPARTIAL	0x080
-
-/* Only these should be used by the drivers */
-/* Which one should you use? If you have a fast card and slow bus,
-   then probably just 0 to indicate fbcon should choose between
-   YWRAP/YPAN+MOVE/YMOVE. On the other side, if you have a fast bus
-   and even better if your card can do fonting (1->8/32bit painting),
-   you should consider either SCROLL_YREDRAW (if your card is
-   able to do neither YPAN/YWRAP), or SCROLL_YNOMOVE.
-   The best is to test it with some real life scrolling (usually, not
-   all lines on the screen are filled completely with non-space characters,
-   and REDRAW performs much better on such lines, so don't cat a file
-   with every line covering all screen columns, it would not be the right
-   benchmark).
- */
-#define SCROLL_YREDRAW		(__SCROLL_YFIXED|__SCROLL_YREDRAW)
-#define SCROLL_YNOMOVE		(__SCROLL_YNOMOVE|__SCROLL_YPANREDRAW)
-
-/* SCROLL_YNOPARTIAL, used in combination with the above, is for video
-   cards which can not handle using panning to scroll a portion of the
-   screen without excessive flicker.  Panning will only be used for
-   whole screens.
- */
-/* Namespace consistency */
-#define SCROLL_YNOPARTIAL	__SCROLL_YNOPARTIAL
+#define SCROLL_YPAN		0x001
+#define SCROLL_YWRAP		0x002
+#define SCROLL_YMOVE		0x003
+#define SCROLL_YREDRAW		0x004
+#define SCROLL_YNOPARTIAL	0x005
+#define SCROLL_YMASK		0x00f
 
 extern int fb_console_init(void);
 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
