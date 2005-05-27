From: sylvain.meyer@worldonline.fr
Subject: [patch 1/1] intelfb-voffset
Date: Sat, 28 May 2005 00:09:31 +0200
Message-ID: <20050527220932.865B91C00449@mwinf0201.wanadoo.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dbn1S-0003oH-Bt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 15:09:42 -0700
Received: from smtp2.wanadoo.fr ([193.252.22.29])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dbn1Q-0006nG-FR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 15:09:42 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0201.wanadoo.fr (SMTP Server) with ESMTP id C755E1C0044A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 May 2005 00:09:33 +0200 (CEST)
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, sylvain.meyer@worldonline.fr


From: Sylvain Meyer <sylvain.meyer@worldonline.fr>

- Add voffset option to avoid conficts with Xorg i810 driver
- Remove __initdata from module param variables

Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
---

 linux-2.6.12-rc4-root/drivers/video/intelfb/intelfbdrv.c |   38 +++++++++------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff -puN drivers/video/intelfb/intelfbdrv.c~intelfb-voffset drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.12-rc4/drivers/video/intelfb/intelfbdrv.c~intelfb-voffset	2005-05-27 23:55:33.000000000 +0200
+++ linux-2.6.12-rc4-root/drivers/video/intelfb/intelfbdrv.c	2005-05-28 00:01:20.000000000 +0200
@@ -228,22 +228,25 @@ MODULE_DESCRIPTION(
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DEVICE_TABLE(pci, intelfb_pci_table);
 
-static int accel        __initdata = 1;
-static int vram         __initdata = 4;
-static int hwcursor     __initdata = 1;
-static int mtrr         __initdata = 1;
-static int fixed        __initdata = 0;
-static int noinit       __initdata = 0;
-static int noregister   __initdata = 0;
-static int probeonly    __initdata = 0;
-static int idonly       __initdata = 0;
-static int bailearly    __initdata = 0;
-static char *mode       __initdata = NULL;
+static int accel        = 1;
+static int vram         = 4;
+static int voffset      = 48;
+static int hwcursor     = 1;
+static int mtrr         = 1;
+static int fixed        = 0;
+static int noinit       = 0;
+static int noregister   = 0;
+static int probeonly    = 0;
+static int idonly       = 0;
+static int bailearly    = 0;
+static char *mode       = NULL;
 
 module_param(accel, bool, S_IRUGO);
 MODULE_PARM_DESC(accel, "Enable console acceleration");
 module_param(vram, int, S_IRUGO);
 MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB");
+module_param(voffset, int, S_IRUGO);
+MODULE_PARM_DESC(voffset, "Offset of framebuffer in MiB");
 module_param(hwcursor, bool, S_IRUGO);
 MODULE_PARM_DESC(hwcursor, "Enable HW cursor");
 module_param(mtrr, bool, S_IRUGO);
@@ -503,6 +506,7 @@ intelfb_pci_register(struct pci_dev *pde
 	struct agp_bridge_data *bridge;
  	int aperture_bar = 0;
  	int mmio_bar = 1;
+	int offset;
 
 	DBG_MSG("intelfb_pci_register\n");
 
@@ -659,17 +663,21 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
+	if (MB(voffset) < stolen_size)
+		offset = (stolen_size >> 12);
+	else
+		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
+
 	/* set the mem offsets - set them after the already used pages */
 	if (dinfo->accel) {
-		dinfo->ring.offset = (stolen_size >> 12)
-			+ gtt_info.current_memory;
+		dinfo->ring.offset = offset + gtt_info.current_memory;
 	}
 	if (dinfo->hwcursor) {
-		dinfo->cursor.offset = (stolen_size >> 12) +
+		dinfo->cursor.offset = offset +
 			+ gtt_info.current_memory + (dinfo->ring.size >> 12);
 	}
 	if (dinfo->fbmem_gart) {
-		dinfo->fb.offset = (stolen_size >> 12) +
+		dinfo->fb.offset = offset +
 			+ gtt_info.current_memory + (dinfo->ring.size >> 12)
 			+ (dinfo->cursor.size >> 12);
 	}
_



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
