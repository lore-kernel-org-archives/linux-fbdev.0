From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/3][FBCON]: New Scrolling Mode: YPAN + REDRAW
Date: Tue, 6 Jul 2004 06:34:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407060634.37125.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bhc2R-0005UY-80
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:15 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bhc2Q-0002FV-6B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:15 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 8195CFDB8B2
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  5 Jul 2004 22:14:14 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Added a new scrolling mode (SCROLL_PAN_REDRAW) to fbcon that should greatly
benefit unaccelerated drivers such as VESA fbdev.  An increase of 3-10 times
in scrolling speed can be expected.

Currently, fbcon has 4 different scrolling methods (1-4). Potentially,
we can have 6. This patch implements SCROLL_PAN_REDRAW (5). SCROLL_WRAP_REDRAW (6)
is still unimplemented.

Scroll Mode		Operation	YPan	YWrap
------------------------------------------------------
1. SCROLL_ACCEL		copyarea	No	No
2. SCROLL_REDRAW	imageblit	No	No
3. SCROLL_PAN		copyarea	Yes	No
4. SCROLL_WRAP		copyarea	No	Yes
5. SCROLL_PAN_REDRAW 	imageblit	Yes	No	
6. SCROLL_WRAP_REDRAW	imageblit	No	Yes
-------------------------------------------------------
Note 1:  I've changed the nomenclature to increase clarity:

SCROLL_ACCEL = SCROLL_MOVE
SCROLL_REDRAW = SCROLL_REDRAW
SCROLL_PAN = SCROLL_PAN_MOVE
SCROLL_WRAP = SCROLL_WRAP_MOVE

To demonstrate the effect of each of the scrolling methods on
an unaccelerated PCI/AGP-based driver (vesafb), I used a simple
benchmark (time cat linux/MAINTAINERS - a 50K text file). The
framebuffer is set at:

1024x768-8bpp, 8x16 font, yres_virtual = 2*yres

1. SCROLL_MOVE:
real    5m50.277s
user    0m0.001s
sys     5m50.227s

Almost 6 minutes for a 50K text file.  Using soft copyarea on a
PCI-based card is just too slow (because copyarea has to 
read from the framebuffer memory).

2. SCROLL_PAN_MOVE
scrollmode: SCROLL_PAN
real    0m8.592s
user    0m0.000s
sys     0m8.586s

Using ypan with copyarea dramatically improves the scrolling.  
However, the scrolling action is jerky (fast during the panning
stages, slows down during the copyarea stages).

3. SCROLL_REDRAW (this is the default scrolling mode)
real    0m3.189s
user    0m0.000s
sys     0m3.170s

Simply eliminating the copyarea, even without ypanning, makes it
faster than SCROLL_PAN_MOvE.  Plus, the scrolling action is smoother.

So, if we combine YPanning with imageblit (PAN_REDRAW), we get this:

4. SCROLL_PAN_REDRAW
real    0m0.520s
user    0m0.000s
sys     0m0.518s

That's almost 6x faster than SCROLL_REDRAW.  Increasing the amount
of video RAM still increases the speed, but not very dramatically.
Higher than 16 MB, the increase is negligible.

Using an accelerated driver, we see almost the same effect but
not as dramatically:

1. SCROLL_MOVE - accel
real    0m3.112s
user    0m0.000s
sys     0m3.112s

2. SCROLL_REDRAW - accel
real    0m2.604s
user    0m0.000s
sys     0m2.603s

Redraw is still faster than move, but not much.

3. SCROLL_PAN_MOVE - accel
real    0m0.203s
user    0m0.000s
sys     0m0.202s

4. SCROLL_PAN_REDRAW - accel
real    0m0.326s
user    0m0.002s
sys     0m0.323s

This is one exception. If panning is enabled, move is
actually faster than redraw. As to why, I don't know.

So based on the above, fbcon will choose the scrolling
method based on the following preference:

Ypan/Ywrap > accel imageblit > accel copyarea >
soft imageblit > (soft copyarea)

Note 2: Exception:
accel copyarea > accel imageblit if Pan/Wrap is enabled.

Note 3: soft copyarea will be avoided by fbcon as much as
possible unless there is a specific override, ie.,
FBINFO_READS_FAST flag is set. If this flag is set,
fbcon will prefer copyarea over imageblit, accel or soft.

As a final note, in order for fbcon to use the best scrolling
method, the low-level drivers must provide the correct hinting
by setting the FBINFO_HWACCEL_* flags.

To vesafb users:  boot vesafb like this for fastest scrolling
action:

video=vesafb:ypan,vram:16

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm6-orig/drivers/video/console/fbcon.c linux-2.6.7-mm6/drivers/video/console/fbcon.c
--- linux-2.6.7-mm6-orig/drivers/video/console/fbcon.c	2004-07-05 21:10:02.309210688 +0000
+++ linux-2.6.7-mm6/drivers/video/console/fbcon.c	2004-07-05 21:10:27.108440632 +0000
@@ -183,6 +183,8 @@
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
 static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc);
+static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
+			      int line, int count, int dy);
 
 #ifdef CONFIG_MAC
 /*
@@ -763,7 +765,7 @@
 
 	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
 	    !(cap & FBINFO_HWACCEL_DISABLED))
-		p->scrollmode = SCROLL_ACCEL;
+		p->scrollmode = SCROLL_MOVE;
 	else /* default to something safe */
 		p->scrollmode = SCROLL_REDRAW;
 
@@ -1226,6 +1228,31 @@
 	scrollback_current = 0;
 }
 
+static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
+{
+	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct display *p = &fb_display[vc->vc_num];
+	int redraw = 0;
+
+	p->yscroll += count;
+	if (p->yscroll > p->vrows - vc->vc_rows) {
+		p->yscroll -= p->vrows - vc->vc_rows;
+		redraw = 1;
+	}
+
+	info->var.xoffset = 0;
+	info->var.yoffset = p->yscroll * vc->vc_font.height;
+	info->var.vmode &= ~FB_VMODE_YWRAP;
+	if (redraw)
+		fbcon_redraw_move(vc, p, t + count, vc->vc_rows - count, t);
+	update_var(vc->vc_num, info);
+	accel_clear_margins(vc, info, 1);
+	scrollback_max += count;
+	if (scrollback_max > scrollback_phys_max)
+		scrollback_max = scrollback_phys_max;
+	scrollback_current = 0;
+}
+
 static __inline__ void ypan_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
@@ -1248,6 +1275,30 @@
 	scrollback_current = 0;
 }
 
+static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
+{
+	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct display *p = &fb_display[vc->vc_num];
+	int redraw = 0;
+
+	p->yscroll -= count;
+	if (p->yscroll < 0) {
+		p->yscroll += p->vrows - vc->vc_rows;
+		redraw = 1;
+	}
+	info->var.xoffset = 0;
+	info->var.yoffset = p->yscroll * vc->vc_font.height;
+	info->var.vmode &= ~FB_VMODE_YWRAP;
+	if (redraw)
+		fbcon_redraw_move(vc, p, t, vc->vc_rows - count, t + count);
+	update_var(vc->vc_num, info);
+	accel_clear_margins(vc, info, 1);
+	scrollback_max -= count;
+	if (scrollback_max < 0)
+		scrollback_max = 0;
+	scrollback_current = 0;
+}
+
 static void fbcon_redraw_softback(struct vc_data *vc, struct display *p,
 				  long delta)
 {
@@ -1343,6 +1394,42 @@
 	}
 }
 
+static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
+			      int line, int count, int dy)
+{
+	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	unsigned short *s = (unsigned short *)
+		(vc->vc_origin + vc->vc_size_row * line);
+
+	while (count--) {
+		unsigned short *start = s;
+		unsigned short *le = advance_row(s, 1);
+		unsigned short c;
+		int x = 0;
+		unsigned short attr = 1;
+
+		do {
+			c = scr_readw(s);
+			if (attr != (c & 0xff00)) {
+				attr = c & 0xff00;
+				if (s > start) {
+					accel_putcs(vc, info, start, s - start,
+						    real_y(p, dy), x);
+					x += s - start;
+					start = s;
+				}
+			}
+			console_conditional_schedule();
+			s++;
+		} while (s < le);
+		if (s > start)
+			accel_putcs(vc, info, start, s - start,
+				    real_y(p, dy), x);
+		console_conditional_schedule();
+		dy++;
+	}
+}
+
 static void fbcon_redraw(struct vc_data *vc, struct display *p,
 			 int line, int count, int offset)
 {
@@ -1455,14 +1542,14 @@
 		if (logo_shown >= 0)
 			goto redraw_up;
 		switch (p->scrollmode) {
-		case SCROLL_ACCEL:
+		case SCROLL_MOVE:
 			accel_bmove(vc, info, t + count, 0, t, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, b - count, 0, count,
 					 vc->vc_cols);
 			break;
 
-		case SCROLL_WRAP:
+		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (t > 0)
 					fbcon_bmove(vc, 0, 0, count, 0, t,
@@ -1480,7 +1567,25 @@
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
-		case SCROLL_PAN:
+		case SCROLL_PAN_REDRAW:
+			if ((p->yscroll + count <=
+			     2 * (p->vrows - vc->vc_rows))
+			    && ((!scroll_partial && (b - t == vc->vc_rows))
+				|| (scroll_partial
+				    && (b - t - count >
+					3 * vc->vc_rows >> 2)))) {
+				if (t > 0)
+					fbcon_redraw_move(vc, p, 0, t, count);
+				ypan_up_redraw(vc, t, count);
+				if (vc->vc_rows - b > 0)
+					fbcon_redraw_move(vc, p, b - count,
+							  vc->vc_rows - b, b);
+			} else 
+				fbcon_redraw_move(vc, p, t + count, b - t - count, t);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			break;
+
+		case SCROLL_PAN_MOVE:
 			if ((p->yscroll + count <=
 			     2 * (p->vrows - vc->vc_rows))
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
@@ -1522,13 +1627,13 @@
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
 		switch (p->scrollmode) {
-		case SCROLL_ACCEL:
+		case SCROLL_MOVE:
 			accel_bmove(vc, info, t, 0, t + count, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, t, 0, count, vc->vc_cols);
 			break;
 
-		case SCROLL_WRAP:
+		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (vc->vc_rows - b > 0)
 					fbcon_bmove(vc, b, 0, b - count, 0,
@@ -1546,7 +1651,7 @@
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
-		case SCROLL_PAN:
+		case SCROLL_PAN_MOVE:
 			if ((count - p->yscroll <= p->vrows - vc->vc_rows)
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
 				|| (scroll_partial
@@ -1568,6 +1673,23 @@
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
+		case SCROLL_PAN_REDRAW:
+			if ((count - p->yscroll <= p->vrows - vc->vc_rows)
+			    && ((!scroll_partial && (b - t == vc->vc_rows))
+				|| (scroll_partial
+				    && (b - t - count >
+					3 * vc->vc_rows >> 2)))) {
+				if (vc->vc_rows - b > 0)
+					fbcon_redraw_move(vc, p, b, vc->vc_rows - b,
+							  b - count);
+				ypan_down_redraw(vc, t, count);
+				if (t > 0)
+					fbcon_redraw_move(vc, p, count, t, 0);
+			} else
+				fbcon_redraw_move(vc, p, t, b - t - count, t + count);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			break;
+
 		case SCROLL_REDRAW:
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
@@ -1657,12 +1779,13 @@
 	int cap = info->flags;
 	int good_pan = (cap & FBINFO_HWACCEL_YPAN)
 		 && divides(info->fix.ypanstep, vc->vc_font.height)
-		 && info->var.yres_virtual >= 2*info->var.yres;
+		 && info->var.yres_virtual > info->var.yres;
 	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP)
 		 && divides(info->fix.ywrapstep, vc->vc_font.height)
 		 && divides(vc->vc_font.height, info->var.yres_virtual);
 	int reading_fast = cap & FBINFO_READS_FAST;
 	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED);
+	int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) && !(cap & FBINFO_HWACCEL_DISABLED);
 
 	p->vrows = info->var.yres_virtual/fh;
 	if (info->var.yres > (fh * (vc->vc_rows + 1)))
@@ -1673,12 +1796,13 @@
 
 	if (good_wrap || good_pan) {
 		if (reading_fast || fast_copyarea)
-			p->scrollmode = good_wrap ? SCROLL_WRAP : SCROLL_PAN;
+			p->scrollmode = good_wrap ? SCROLL_WRAP_MOVE : SCROLL_PAN_MOVE;
 		else
-			p->scrollmode = SCROLL_REDRAW;
+			p->scrollmode = good_wrap ? SCROLL_REDRAW :
+				SCROLL_PAN_REDRAW;
 	} else {
-		if (reading_fast || fast_copyarea)
-			p->scrollmode = SCROLL_ACCEL;
+		if (reading_fast || (fast_copyarea && !fast_imageblit))
+			p->scrollmode = SCROLL_MOVE;
 		else
 			p->scrollmode = SCROLL_REDRAW;
 	}
@@ -1774,10 +1898,11 @@
 	}
 
 	switch (p->scrollmode) {
-	case SCROLL_WRAP:
+	case SCROLL_WRAP_MOVE:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
 		break;
-	case SCROLL_PAN:
+	case SCROLL_PAN_MOVE:
+	case SCROLL_PAN_REDRAW:
 		scrollback_phys_max = p->vrows - 2 * vc->vc_rows;
 		if (scrollback_phys_max < 0)
 			scrollback_phys_max = 0;
@@ -2363,10 +2488,11 @@
 	offset = p->yscroll - scrollback_current;
 	limit = p->vrows;
 	switch (p->scrollmode) {
-	case SCROLL_WRAP:
+	case SCROLL_WRAP_MOVE:
 		info->var.vmode |= FB_VMODE_YWRAP;
 		break;
-	case SCROLL_PAN:
+	case SCROLL_PAN_MOVE:
+	case SCROLL_PAN_REDRAW:
 		limit -= vc->vc_rows;
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 		break;
diff -Naur linux-2.6.7-mm6-orig/drivers/video/console/fbcon.h linux-2.6.7-mm6/drivers/video/console/fbcon.h
--- linux-2.6.7-mm6-orig/drivers/video/console/fbcon.h	2004-07-05 21:10:02.332207192 +0000
+++ linux-2.6.7-mm6/drivers/video/console/fbcon.h	2004-07-05 13:45:14.000000000 +0000
@@ -69,6 +69,35 @@
      
 /* There are several methods fbcon can use to move text around the screen:
  *
+ *                     Operation   Pan    Wrap
+ *---------------------------------------------
+ * SCROLL_MOVE         copyarea    No     No
+ * SCROLL_PAN_MOVE     copyarea    Yes    No
+ * SCROLL_WRAP_MOVE    copyarea    No     Yes
+ * SCROLL_REDRAW       imageblit   No     No
+ * SCROLL_PAN_REDRAW   imageblit   Yes    No
+ * SCROLL_WRAP_REDRAW  imageblit   No     Yes
+ *
+ * (SCROLL_WRAP_REDRAW is not implemented yet)
+ *
+ * In general, fbcon will choose the best scrolling
+ * method based on the rule below:
+ *
+ * Pan/Wrap > accel imageblit > accel copyarea >
+ * soft imageblit > (soft copyarea)
+ *
+ * Exception to the rule: Pan + accel copyarea is
+ * preferred over Pan + accel imageblit.
+ *
+ * The above is typical for PCI/AGP cards. Unless
+ * overridden, fbcon will never use soft copyarea.
+ *
+ * If you need to override the above rule, set the 
+ * appropriate flags in fb_info->flags.  For example,
+ * to prefer copyarea over imageblit, set
+ * FBINFO_READS_FAST.
+ *
+ * Other notes:
  * + use the hardware engine to move the text
  *    (hw-accelerated copyarea() and fillrect())
  * + use hardware-supported panning on a large virtual screen
@@ -84,10 +113,11 @@
  *
  */
 
-#define SCROLL_ACCEL	0x001
-#define SCROLL_PAN	0x002
-#define SCROLL_WRAP	0x003
-#define SCROLL_REDRAW	0x004
+#define SCROLL_MOVE	   0x001
+#define SCROLL_PAN_MOVE	   0x002
+#define SCROLL_WRAP_MOVE   0x003
+#define SCROLL_REDRAW	   0x004
+#define SCROLL_PAN_REDRAW  0x005
 
 extern int fb_console_init(void);
 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
