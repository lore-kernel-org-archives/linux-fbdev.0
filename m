From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb: make pan and copyarea() play nice
Date: Thu, 3 Jun 2004 22:28:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040604022838.GB4175@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW4Rq-0000TM-KW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 19:28:46 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW4Rp-0006FH-Bu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 19:28:45 -0700
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
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net


Dear Ben,

Please apply this to radeon with the previous fb accel capabilities patch
I sent you.  This patch solves a couple of screen garbage issues I saw when 
trying to use both panning and copyarea()/fillrect().   

For some reason, I've got to sync() the engine after each copyarea()/
fillrect() call.  I don't know why this should be, but when I do, the
corruption goes away...

-dte

radeonfb: make copyarea() and fillrect() play nicely with panning and large 
    virtual screens
 
# drivers/video/aty/radeon_base.c
#   2004/06/04 03:10:58+02:00 eger@rosencrantz.theboonies.us +1 -0
#   make radeon accel play nice when the user wants to have a large virtual
#   screen to pan on.  fix previous drain bramage.
# 
# drivers/video/aty/radeon_accel.c
#   2004/06/04 03:10:58+02:00 eger@rosencrantz.theboonies.us +6 -4
#   make radeon accel play nice when the user wants to have a large virtual
#   screen to pan on.  fix previous drain bramage.
# 
diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	Fri Jun  4 03:14:04 2004
+++ b/drivers/video/aty/radeon_accel.c	Fri Jun  4 03:14:04 2004
@@ -35,8 +35,8 @@
 		return;
 	}
 
-	vxres = info->var.xres;
-	vyres = info->var.yres;
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
 	memcpy(&modded, region, sizeof(struct fb_fillrect));
 
@@ -48,6 +48,7 @@
 	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
 
 	radeonfb_prim_fillrect(rinfo, &modded);
+	radeonfb_sync(info);  /* is there a less weighty way? */
 }
 
 static void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
@@ -101,8 +102,8 @@
 		return;
 	}
 
-	vxres = info->var.xres;
-	vyres = info->var.yres;
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
 	if(!modded.width || !modded.height ||
 	   modded.sx >= vxres || modded.sy >= vyres ||
@@ -115,6 +116,7 @@
 	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
   
 	radeonfb_prim_copyarea(rinfo, &modded);
+	radeonfb_sync(info);  /* is there a less weighty way? */
 }
 
 void radeonfb_imageblit(struct fb_info *info, const struct fb_image *image)
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Fri Jun  4 03:14:04 2004
+++ b/drivers/video/aty/radeon_base.c	Fri Jun  4 03:14:04 2004
@@ -1779,6 +1779,7 @@
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
 	info->flags = FBINFO_DEFAULT
+		    | FBINFO_READS_FAST
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
 		    | FBINFO_HWACCEL_XPAN


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
