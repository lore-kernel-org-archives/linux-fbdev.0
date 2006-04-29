From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/12] fbdev: More accurate sync range extrapolation
Date: Sat, 29 Apr 2006 08:26:49 +0800
Message-ID: <4452B2C9.1050104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdhp-0003iM-I8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:05 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdhp-00015u-MO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:05 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdho-0006gw-TW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:05 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The EDID block should specify the display's operating limits (vertical and 
horizontal sync ranges, and maximum dot clock).  If not given by the EDID
block, the ranges are extrapolated from the modelist.  However, the 
computation used is only a rough approximation, and the resulting values may
not reflect the actual capability of the display.  This problem is frequently
encountered when the EDID block has a single entry, the single mode entry will
fail validation.

To prevent this, calculate the values based on the same method used in
fb_validate_mode().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmon.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index fbbcb71..87b0224 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -605,6 +605,7 @@ static int fb_get_monitor_limits(unsigne
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 
 	DPRINTK("      Monitor Operating Limits: ");
+
 	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
 		if (edid_is_limits_block(block)) {
 			specs->hfmin = H_MIN_RATE * 1000;
@@ -618,11 +619,12 @@ static int fb_get_monitor_limits(unsigne
 			break;
 		}
 	}
-	
+
 	/* estimate monitor limits based on modes supported */
 	if (retval) {
-		struct fb_videomode *modes;
+		struct fb_videomode *modes, *mode;
 		int num_modes, i, hz, hscan, pixclock;
+		int vtotal, htotal;
 
 		modes = fb_create_modedb(edid, &num_modes);
 		if (!modes) {
@@ -632,20 +634,38 @@ static int fb_get_monitor_limits(unsigne
 
 		retval = 0;
 		for (i = 0; i < num_modes; i++) {
-			hz = modes[i].refresh;
+			mode = &modes[i];
 			pixclock = PICOS2KHZ(modes[i].pixclock) * 1000;
-			hscan = (modes[i].yres * 105 * hz + 5000)/100;
+			htotal = mode->xres + mode->right_margin + mode->hsync_len
+				+ mode->left_margin;
+			vtotal = mode->yres + mode->lower_margin + mode->vsync_len
+				+ mode->upper_margin;
+
+			if (mode->vmode & FB_VMODE_INTERLACED)
+				vtotal /= 2;
+
+			if (mode->vmode & FB_VMODE_DOUBLE)
+				vtotal *= 2;
+
+			hscan = (pixclock + htotal / 2) / htotal;
+			hscan = (hscan + 500) / 1000 * 1000;
+			hz = (hscan + vtotal / 2) / vtotal;
 			
 			if (specs->dclkmax == 0 || specs->dclkmax < pixclock)
 				specs->dclkmax = pixclock;
+
 			if (specs->dclkmin == 0 || specs->dclkmin > pixclock)
 				specs->dclkmin = pixclock;
+
 			if (specs->hfmax == 0 || specs->hfmax < hscan)
 				specs->hfmax = hscan;
+
 			if (specs->hfmin == 0 || specs->hfmin > hscan)
 				specs->hfmin = hscan;
+
 			if (specs->vfmax == 0 || specs->vfmax < hz)
 				specs->vfmax = hz;
+
 			if (specs->vfmin == 0 || specs->vfmin > hz)
 				specs->vfmin = hz;
 		}



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
