From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] fbcon: prefer pan when available
Date: Thu, 3 Jun 2004 22:24:50 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040604022450.GA4175@havoc.gtf.org>
References: <20040603023653.GA20951@havoc.gtf.org> <200406032307.13121.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW4OA-00006T-It
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 19:24:58 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW4O9-0005bU-UE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 19:24:58 -0700
Content-Disposition: inline
In-Reply-To: <200406032307.13121.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


Dear Andrew,

Thomas and Antonino are right; the following are better heuristics
than I had for interpreting the accel flags.  please apply on top of
2.6.7-rc2-mm2

-dte

fbcon: improve heuristics to favor panning over copyarea()
  thanks to pseudocode from Antonino Daplas <adaplas@hotpop.com>

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Fri Jun  4 02:58:58 2004
+++ b/drivers/video/console/fbcon.c	Fri Jun  4 02:58:58 2004
@@ -1469,22 +1469,26 @@
 static __inline__ void updatescrollmode(struct display *p, struct fb_info *info, struct vc_data *vc)
 {
 	int cap = info->flags;
+	int good_pan = (cap & FBINFO_HWACCEL_YPAN)
+		 && divides(info->fix.ypanstep, vc->vc_font.height)
+		 && info->var.yres_virtual >= 2*info->var.yres;
+	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP)
+		 && divides(info->fix.ywrapstep, vc->vc_font.height)
+		 && divides(vc->vc_font.height, info->var.yres_virtual);
+	int reading_fast = cap & FBINFO_READS_FAST;
+	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED);
 
-	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
-		p->scrollmode = SCROLL_ACCEL;
-	else if ((cap & FBINFO_HWACCEL_YWRAP) &&
-		 divides(info->fix.ywrapstep, vc->vc_font.height) &&
-		 divides(vc->vc_font.height, info->var.yres_virtual))
-		p->scrollmode = SCROLL_WRAP;
-	else if ((cap & FBINFO_HWACCEL_YPAN) &&
-		 divides(info->fix.ypanstep, vc->vc_font.height) &&
-		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
-		p->scrollmode = SCROLL_PAN;
-	else if (cap & FBINFO_READS_FAST)
-		/* okay, we'll use software version of accel funcs... */
-		p->scrollmode = SCROLL_ACCEL; 
-	else
-		p->scrollmode = SCROLL_REDRAW;
+	if (good_wrap || good_pan) {
+		if (reading_fast || fast_copyarea)	
+			p->scrollmode = good_wrap ? SCROLL_WRAP : SCROLL_PAN;
+		else
+			p->scrollmode = SCROLL_REDRAW;
+	} else {
+		if (reading_fast || fast_copyarea)
+			p->scrollmode = SCROLL_ACCEL;
+		else
+			p->scrollmode = SCROLL_REDRAW;
+	}
 }
 
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
