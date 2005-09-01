From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/10] fbdev: Initialize var structure in calc_mode_timings
Date: Fri, 02 Sep 2005 05:39:12 +0800
Message-ID: <43177500.8040104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2c-0004lK-HR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:14 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2b-0003u6-Gz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:14 -0700
Received: by wproxy.gmail.com with SMTP id i3so393063wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:07 -0700 (PDT)
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

    The var structure in calc_mode_timings is not properly initialized
    (zero set) which leads to undefined behavior when it is passed to
    fb_get_mode().
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 fbmon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -314,11 +314,13 @@ static int edid_is_monitor_block(unsigne
 		return 0;
 }
 
-static void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
+static void calc_mode_timings(int xres, int yres, int refresh,
+			      struct fb_videomode *mode)
 {
 	struct fb_var_screeninfo var;
 	struct fb_info info;
 	
+	memset(&var, 0, sizeof(struct fb_var_screeninfo));
 	var.xres = xres;
 	var.yres = yres;
 	fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
