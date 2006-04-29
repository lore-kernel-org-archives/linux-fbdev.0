From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/12] atyfb: Set correct acceleration flags
Date: Sat, 29 Apr 2006 08:33:49 +0800
Message-ID: <4452B46D.7070900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdiE-0003o7-0H
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:30 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiE-00016v-58
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:30 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiC-0006gw-TC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:30 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:28 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

Set the appropriate acceleration flags so fbcon can choose the optimal
scrolling mode.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d9d7d3c..4813e4a 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -1280,6 +1280,14 @@ static int atyfb_set_par(struct fb_info 
 
 	par->accel_flags = var->accel_flags; /* hack */
 
+	if (var->accel_flags) {
+		info->fbops->fb_sync = atyfb_sync;
+		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+	} else {
+		info->fbops->fb_sync = NULL;
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
+
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
 
@@ -2506,7 +2514,11 @@ static int __init aty_init(struct fb_inf
 
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = pseudo_palette;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT           |
+	              FBINFO_HWACCEL_IMAGEBLIT |
+	              FBINFO_HWACCEL_FILLRECT  |
+	              FBINFO_HWACCEL_COPYAREA  |
+	              FBINFO_HWACCEL_YPAN;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && machine_is_compatible("PowerBook1,1")) {



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
