From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 5/10] fb_videomode_to_var: reset virtual
	screen parameters
Date: Thu, 8 Feb 2007 14:59:11 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702081459020.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HF9nz-0001rV-Kf for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:59:19 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HF9ny-0003rx-8T
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:59:19 -0800
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

fb_videomode_to_var(): reset the virtual screen parameters when converting from
an fb_videomode to an fb_var_screeninfo.

Without this the old virtual screen parameters are kept. Hence you cannot
switch to a video mode with a lower resolution on frame buffer devices that
don't support virtual screens and panning, as values are not supposed to be
rounded down when they don't fit.

I also reordered the assignments to match the order of the individual members.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/modedb.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/video/modedb.c
+++ ps3-linux-2.6.20/drivers/video/modedb.c
@@ -716,13 +716,17 @@ void fb_videomode_to_var(struct fb_var_s
 {
 	var->xres = mode->xres;
 	var->yres = mode->yres;
+	var->xres_virtual = mode->xres;
+	var->yres_virtual = mode->yres;
+	var->xoffset = 0;
+	var->yoffset = 0;
 	var->pixclock = mode->pixclock;
 	var->left_margin = mode->left_margin;
-	var->hsync_len = mode->hsync_len;
-	var->vsync_len = mode->vsync_len;
 	var->right_margin = mode->right_margin;
 	var->upper_margin = mode->upper_margin;
 	var->lower_margin = mode->lower_margin;
+	var->hsync_len = mode->hsync_len;
+	var->vsync_len = mode->vsync_len;
 	var->sync = mode->sync;
 	var->vmode = mode->vmode & FB_VMODE_MASK;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
