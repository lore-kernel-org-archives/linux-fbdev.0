From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/11] i810fb: Module param fix
Date: Thu, 13 Jan 2005 21:01:35 +0800
Message-ID: <20050113214630.5AAE81A00A1@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCnx-000154-0S
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:57 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCnv-0000Em-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:56 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0F807C892FB
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:41 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Domen Puncer <domen@coderock.org>

  Last parameter is file permition in sysfs, not default value.
  (If 0, file is not accessible trough sysfs, and that's what i did.)


Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 i810_main.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-12-29 17:43:05 +08:00
@@ -2003,20 +2003,20 @@
 	return pci_register_driver(&i810fb_driver);
 }
 
-module_param(vram, int, 4);
+module_param(vram, int, 0);
 MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB" 
 		 " (default=4)");
 module_param(voffset, int, 0);
 MODULE_PARM_DESC(voffset, "at what offset to place start of framebuffer "
                  "memory (0 to maximum aperture size), in MiB (default = 48)");
-module_param(bpp, int, 8);
+module_param(bpp, int, 0);
 MODULE_PARM_DESC(bpp, "Color depth for display in bits per pixel"
 		 " (default = 8)");
-module_param(xres, int, 640);
+module_param(xres, int, 0);
 MODULE_PARM_DESC(xres, "Horizontal resolution in pixels (default = 640)");
-module_param(yres, int, 480);
+module_param(yres, int, 0);
 MODULE_PARM_DESC(yres, "Vertical resolution in scanlines (default = 480)");
-module_param(vyres,int, 480);
+module_param(vyres,int, 0);
 MODULE_PARM_DESC(vyres, "Virtual vertical resolution in scanlines"
 		 " (default = 480)");
 module_param(hsync1, int, 0);




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
