From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: more updates
Date: Tue, 10 Feb 2004 21:42:36 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076409755.873.13.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVLo-0005Se-R1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:42:44 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqVLf-0008GN-GW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:42:35 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

Some last minute updates to radeonfb :) Remove obsolete memset
(and fix a bug where we would lose rinfo->info and thus crash
at boot, I though I sent that fix to you already but apparently
I missed it).

Remove some bitfields (useless & evil)

Also shield the accel functions vs. a sleeping ship (see my other
comment, it's rather difficult to prevent fbcon to trying to draw
anyway, so rather than adding dummy functions, I added those checks)

This drivers with the uptodate fbdev code works, sleeps & wakes up
fine on pmac laptops.

diff -urN fbdev-2.5/drivers/video/aty/radeon_accel.c linuxppc-2.5-benh/drivers/video/aty/radeon_accel.c
--- fbdev-2.5/drivers/video/aty/radeon_accel.c	2004-02-10 21:15:18.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_accel.c	2004-02-10 21:04:41.000000000 +1100
@@ -28,6 +28,8 @@
 	struct fb_fillrect modded;
 	int vxres, vyres;
   
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
 	if (radeon_accel_disabled()) {
 		cfb_fillrect(info, region);
 		return;
@@ -79,6 +81,8 @@
 	modded.width  = area->width;
 	modded.height = area->height;
   
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
 	if (radeon_accel_disabled()) {
 		cfb_copyarea(info, area);
 		return;
@@ -104,6 +108,8 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
 	radeon_engine_idle();
 
 	cfb_imageblit(info, image);
@@ -113,6 +119,8 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return 0;
 	radeon_engine_idle();
 
 	return 0;
diff -urN fbdev-2.5/drivers/video/aty/radeon_base.c linuxppc-2.5-benh/drivers/video/aty/radeon_base.c
--- fbdev-2.5/drivers/video/aty/radeon_base.c	2004-02-10 21:15:18.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_base.c	2004-02-09 18:51:22.000000000 +1100
@@ -727,7 +727,7 @@
 
 static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+	struct radeonfb_info *rinfo = info->par;
         struct fb_var_screeninfo v;
         int nom, den;
 	unsigned int pitch;
@@ -1703,9 +1703,7 @@
 
 static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
 {
-	struct fb_info *info;
-
-	info = rinfo->info;
+	struct fb_info *info = rinfo->info;
 
 	info->currcon = -1;
 	info->par = rinfo;
@@ -2006,9 +2004,7 @@
 		return -ENODEV;
 	}
 	rinfo = info->par;
-	rinfo->info = info;
-	
-	memset (rinfo, 0, sizeof (struct radeonfb_info));
+	rinfo->info = info;	
 	rinfo->pdev = pdev;
 	
 	spin_lock_init(&rinfo->reg_lock);
diff -urN fbdev-2.5/drivers/video/aty/radeonfb.h linuxppc-2.5-benh/drivers/video/aty/radeonfb.h
--- fbdev-2.5/drivers/video/aty/radeonfb.h	2004-02-10 21:15:18.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/aty/radeonfb.h	2004-02-09 18:51:22.000000000 +1100
@@ -285,12 +285,12 @@
 
 	int			pitch, bpp, depth;
 
-	int			has_CRTC2 : 1;
-	int			is_mobility : 1;
-	int			is_IGP : 1;
-	int			R300_cg_workaround : 1;
-	int			reversed_DAC : 1;
-	int			reversed_TMDS : 1;
+	int			has_CRTC2;
+	int			is_mobility;
+	int			is_IGP;
+	int			R300_cg_workaround;
+	int			reversed_DAC;
+	int			reversed_TMDS;
 	struct panel_info	panel_info;
 	int			mon1_type;
 	u8			*mon1_EDID;




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
