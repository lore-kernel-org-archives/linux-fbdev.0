From: Domen Puncer <domen@coderock.org>
Subject: [patch] video/i810: module_param fixes
Date: Wed, 29 Dec 2004 10:47:07 +0100
Message-ID: <20041229094707.GB21404@nd47.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CjaPq-0002Ze-Oj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Dec 2004 01:46:50 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CjaPo-00077b-H9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Dec 2004 01:46:50 -0800
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Last parameter is file permition in sysfs, not default value.
(If 0, file is not accessible trough sysfs, and that's what i did.)


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/drivers/video/i810/i810_main.c	2004-12-25 15:50:20.000000000 +0100
+++ a/drivers/video/i810/i810_main.c	2004-12-29 10:43:05.000000000 +0100
@@ -2002,20 +2002,20 @@ int __init i810fb_init(void)
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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
