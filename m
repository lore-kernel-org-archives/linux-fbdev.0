From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/15] fbdev: Convert MODULE_PARM to module_param in i810fb
Date: Fri, 29 Oct 2004 09:58:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.04786.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM20-0005tT-Ao
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:20 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM1z-0001KO-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:20 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9F36B969AE1
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:11 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Convert MODULE_PARM to module_param in i810fb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 i810_main.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-27 16:28:37 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-10-28 20:22:51 +08:00
@@ -1994,44 +1994,44 @@
 	return pci_register_driver(&i810fb_driver);
 }
 
-MODULE_PARM(vram, "i");
+module_param(vram, int, 4);
 MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB" 
 		 " (default=4)");
-MODULE_PARM(voffset, "i");
+module_param(voffset, int, 0);
 MODULE_PARM_DESC(voffset, "at what offset to place start of framebuffer "
                  "memory (0 to maximum aperture size), in MiB (default = 48)");
-MODULE_PARM(bpp, "i");
+module_param(bpp, int, 8);
 MODULE_PARM_DESC(bpp, "Color depth for display in bits per pixel"
 		 " (default = 8)");
-MODULE_PARM(xres, "i");
+module_param(xres, int, 640);
 MODULE_PARM_DESC(xres, "Horizontal resolution in pixels (default = 640)");
-MODULE_PARM(yres, "i");
+module_param(yres, int, 480);
 MODULE_PARM_DESC(yres, "Vertical resolution in scanlines (default = 480)");
-MODULE_PARM(vyres, "i");
+module_param(vyres,int, 480);
 MODULE_PARM_DESC(vyres, "Virtual vertical resolution in scanlines"
 		 " (default = 480)");
-MODULE_PARM(hsync1, "i");
+module_param(hsync1, int, 0);
 MODULE_PARM_DESC(hsync1, "Minimum horizontal frequency of monitor in KHz"
 		 " (default = 31)");
-MODULE_PARM(hsync2, "i");
+module_param(hsync2, int, 0);
 MODULE_PARM_DESC(hsync2, "Maximum horizontal frequency of monitor in KHz"
 		 " (default = 31)");
-MODULE_PARM(vsync1, "i");
+module_param(vsync1, int, 0);
 MODULE_PARM_DESC(vsync1, "Minimum vertical frequency of monitor in Hz"
 		 " (default = 50)");
-MODULE_PARM(vsync2, "i");
+module_param(vsync2, int, 0);
 MODULE_PARM_DESC(vsync2, "Maximum vertical frequency of monitor in Hz" 
 		 " (default = 60)");
-MODULE_PARM(accel, "i");
+module_param(accel, bool, 0);
 MODULE_PARM_DESC(accel, "Use Acceleration (BLIT) engine (default = 0)");
-MODULE_PARM(mtrr, "i");
+module_param(mtrr, bool, 0);
 MODULE_PARM_DESC(mtrr, "Use MTRR (default = 0)");
-MODULE_PARM(ext_vga, "i");
+module_param(ext_vga, bool, 0);
 MODULE_PARM_DESC(ext_vga, "Enable external VGA connector (default = 0)");
-MODULE_PARM(sync, "i");
+module_param(sync, bool, 0);
 MODULE_PARM_DESC(sync, "wait for accel engine to finish drawing"
 		 " (default = 0)");
-MODULE_PARM(dcolor, "i");
+module_param(dcolor, bool, 0);
 MODULE_PARM_DESC(dcolor, "use DirectColor visuals"
 		 " (default = 0 = TrueColor)");
 




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
