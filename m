From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/6] atyfb: Add boot/module option to override composite sync
Date: Sun, 13 Mar 2005 08:32:39 +0800
Message-ID: <200503130832.41113.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH5W-0003pd-IS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:10 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH5U-0008Pi-Nc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:10 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 94E3A14AD885
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:01 +0000 (UTC)
Content-Disposition: inline
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

  Some SPARC-based displays need the composite sync set to high.
  Since none of the entries in the default db has the composite
  sync set to high, using fb_find_mode() will produce a blank
  display.

  Add this new option to Documentation/fb/aty128fb.txt

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Documentation/fb/aty128fb.txt  |    1 +
 drivers/video/aty/atyfb_base.c |   13 +++++++++++++
 2 files changed, 14 insertions(+)

diff -Nru a/Documentation/fb/aty128fb.txt b/Documentation/fb/aty128fb.txt
--- a/Documentation/fb/aty128fb.txt	2005-03-12 22:23:57 +08:00
+++ b/Documentation/fb/aty128fb.txt	2005-03-13 07:35:30 +08:00
@@ -54,6 +54,7 @@
 
 noaccel  - do not use acceleration engine. It is default.
 accel    - use acceleration engine. Not finished.
+comp_sync- set composite sync, 0 for low, 1 for high.
 vmode:x  - chooses PowerMacintosh video mode <x>. Depreciated.
 cmode:x  - chooses PowerMacintosh colour mode <x>. Depreciated.
 <XxX@X>  - selects startup videomode. See modedb.txt for detailed
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-03-12 23:23:49 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2005-03-13 07:35:31 +08:00
@@ -307,6 +307,7 @@
 static int pll;
 static int mclk;
 static int xclk;
+static int comp_sync __initdata = -1;
 static char *mode;
 
 #ifdef CONFIG_PPC
@@ -2527,6 +2528,13 @@
 	else
 		var.accel_flags |= FB_ACCELF_TEXT;
 
+	if (comp_sync != -1) {
+		if (!comp_sync)
+			var.sync &= ~FB_SYNC_COMP_HIGH_ACT;
+		else
+			var.sync |= FB_SYNC_COMP_HIGH_ACT;
+	}
+
 	if (var.yres == var.yres_virtual) {
 		u32 videoram = (info->fix.smem_len - (PAGE_SIZE << 2));
 		var.yres_virtual = ((videoram * 8) / var.bits_per_pixel) / var.xres_virtual;
@@ -3612,6 +3620,8 @@
 			mclk = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "xclk:", 5))
 			xclk = simple_strtoul(this_opt+5, NULL, 0);
+		else if (!strncmp(this_opt, "comp_sync:", 10))
+			comp_sync = simple_strtoul(this_opt+10, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode =
@@ -3701,6 +3711,9 @@
 MODULE_PARM_DESC(mclk, "int: override memory clock");
 module_param(xclk, int, 0);
 MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
+module_param(comp_sync, int, 0);
+MODULE_PARM_DESC(comp_sync,
+		 "Set composite sync signal to low (0) or high (1)");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
