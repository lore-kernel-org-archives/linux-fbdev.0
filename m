From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/9] fbdev: Reduce stack usage
Date: Tue, 20 Dec 2005 20:48:59 +0800
Message-ID: <43A7FDBB.1010601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyEX-0002AY-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:17:57 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyEW-0005Kv-Tu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:17:57 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:17:56 -0800 (PST)
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

calc_mode_timings() and fb_get_mode() are using more than 500 bytes
off the stack. Fix.
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmon.c |  128 ++++++++++++++++++++++++++-----------------------
 1 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index fc7965b..0ef75a9 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -317,26 +317,29 @@ static int edid_is_monitor_block(unsigne
 static void calc_mode_timings(int xres, int yres, int refresh,
 			      struct fb_videomode *mode)
 {
-	struct fb_var_screeninfo var;
-	struct fb_info info;
+	struct fb_var_screeninfo *var;
 	
-	memset(&var, 0, sizeof(struct fb_var_screeninfo));
-	var.xres = xres;
-	var.yres = yres;
-	fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 
-		    refresh, &var, &info);
-	mode->xres = xres;
-	mode->yres = yres;
-	mode->pixclock = var.pixclock;
-	mode->refresh = refresh;
-	mode->left_margin = var.left_margin;
-	mode->right_margin = var.right_margin;
-	mode->upper_margin = var.upper_margin;
-	mode->lower_margin = var.lower_margin;
-	mode->hsync_len = var.hsync_len;
-	mode->vsync_len = var.vsync_len;
-	mode->vmode = 0;
-	mode->sync = 0;
+	var = kzalloc(sizeof(struct fb_var_screeninfo), GFP_KERNEL);
+
+	if (var) {
+		var->xres = xres;
+		var->yres = yres;
+		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON,
+			    refresh, var, NULL);
+		mode->xres = xres;
+		mode->yres = yres;
+		mode->pixclock = var->pixclock;
+		mode->refresh = refresh;
+		mode->left_margin = var->left_margin;
+		mode->right_margin = var->right_margin;
+		mode->upper_margin = var->upper_margin;
+		mode->lower_margin = var->lower_margin;
+		mode->hsync_len = var->hsync_len;
+		mode->vsync_len = var->vsync_len;
+		mode->vmode = 0;
+		mode->sync = 0;
+		kfree(var);
+	}
 }
 
 static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
@@ -1105,15 +1108,21 @@ static void fb_timings_dclk(struct __fb_
  */ 
 int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct __fb_timings timings;
+	struct __fb_timings *timings;
 	u32 interlace = 1, dscan = 1;
-	u32 hfmin, hfmax, vfmin, vfmax, dclkmin, dclkmax;
+	u32 hfmin, hfmax, vfmin, vfmax, dclkmin, dclkmax, err = 0;
+
+
+	timings = kzalloc(sizeof(struct __fb_timings), GFP_KERNEL);
+
+	if (!timings)
+		return -ENOMEM;
 
 	/* 
 	 * If monspecs are invalid, use values that are enough
 	 * for 640x480@60
 	 */
-	if (!info->monspecs.hfmax || !info->monspecs.vfmax ||
+	if (!info || !info->monspecs.hfmax || !info->monspecs.vfmax ||
 	    !info->monspecs.dclkmax ||
 	    info->monspecs.hfmax < info->monspecs.hfmin ||
 	    info->monspecs.vfmax < info->monspecs.vfmin ||
@@ -1130,65 +1139,66 @@ int fb_get_mode(int flags, u32 val, stru
 		dclkmax = info->monspecs.dclkmax;
 	}
 
-	memset(&timings, 0, sizeof(struct __fb_timings));
-	timings.hactive = var->xres;
-	timings.vactive = var->yres;
+	timings->hactive = var->xres;
+	timings->vactive = var->yres;
 	if (var->vmode & FB_VMODE_INTERLACED) { 
-		timings.vactive /= 2;
+		timings->vactive /= 2;
 		interlace = 2;
 	}
 	if (var->vmode & FB_VMODE_DOUBLE) {
-		timings.vactive *= 2;
+		timings->vactive *= 2;
 		dscan = 2;
 	}
 
 	switch (flags & ~FB_IGNOREMON) {
 	case FB_MAXTIMINGS: /* maximize refresh rate */
-		timings.hfreq = hfmax;
-		fb_timings_hfreq(&timings);
-		if (timings.vfreq > vfmax) {
-			timings.vfreq = vfmax;
-			fb_timings_vfreq(&timings);
-		}
-		if (timings.dclk > dclkmax) {
-			timings.dclk = dclkmax;
-			fb_timings_dclk(&timings);
+		timings->hfreq = hfmax;
+		fb_timings_hfreq(timings);
+		if (timings->vfreq > vfmax) {
+			timings->vfreq = vfmax;
+			fb_timings_vfreq(timings);
+		}
+		if (timings->dclk > dclkmax) {
+			timings->dclk = dclkmax;
+			fb_timings_dclk(timings);
 		}
 		break;
 	case FB_VSYNCTIMINGS: /* vrefresh driven */
-		timings.vfreq = val;
-		fb_timings_vfreq(&timings);
+		timings->vfreq = val;
+		fb_timings_vfreq(timings);
 		break;
 	case FB_HSYNCTIMINGS: /* hsync driven */
-		timings.hfreq = val;
-		fb_timings_hfreq(&timings);
+		timings->hfreq = val;
+		fb_timings_hfreq(timings);
 		break;
 	case FB_DCLKTIMINGS: /* pixelclock driven */
-		timings.dclk = PICOS2KHZ(val) * 1000;
-		fb_timings_dclk(&timings);
+		timings->dclk = PICOS2KHZ(val) * 1000;
+		fb_timings_dclk(timings);
 		break;
 	default:
-		return -EINVAL;
+		err = -EINVAL;
 		
 	} 
 	
-	if (!(flags & FB_IGNOREMON) && 
-	    (timings.vfreq < vfmin || timings.vfreq > vfmax || 
-	     timings.hfreq < hfmin || timings.hfreq > hfmax ||
-	     timings.dclk < dclkmin || timings.dclk > dclkmax))
-		return -EINVAL;
-
-	var->pixclock = KHZ2PICOS(timings.dclk/1000);
-	var->hsync_len = (timings.htotal * 8)/100;
-	var->right_margin = (timings.hblank/2) - var->hsync_len;
-	var->left_margin = timings.hblank - var->right_margin - var->hsync_len;
-	
-	var->vsync_len = (3 * interlace)/dscan;
-	var->lower_margin = (1 * interlace)/dscan;
-	var->upper_margin = (timings.vblank * interlace)/dscan - 
-		(var->vsync_len + var->lower_margin);
+	if (err || (!(flags & FB_IGNOREMON) &&
+	    (timings->vfreq < vfmin || timings->vfreq > vfmax ||
+	     timings->hfreq < hfmin || timings->hfreq > hfmax ||
+	     timings->dclk < dclkmin || timings->dclk > dclkmax))) {
+		err = -EINVAL;
+	} else {
+		var->pixclock = KHZ2PICOS(timings->dclk/1000);
+		var->hsync_len = (timings->htotal * 8)/100;
+		var->right_margin = (timings->hblank/2) - var->hsync_len;
+		var->left_margin = timings->hblank - var->right_margin -
+			var->hsync_len;
+		var->vsync_len = (3 * interlace)/dscan;
+		var->lower_margin = (1 * interlace)/dscan;
+		var->upper_margin = (timings->vblank * interlace)/dscan -
+			(var->vsync_len + var->lower_margin);
+	}
 	
-	return 0;
+	kfree(timings);
+	return err;
 }
 #else
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
