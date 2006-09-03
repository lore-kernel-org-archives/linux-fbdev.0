From: syrjala@sci.fi
Subject: [patch 8/9] atyfb: Improve atyfb_atari_probe()
Date: Mon, 04 Sep 2006 01:06:55 +0300
Message-ID: <20060903220704.533694946@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1849024090=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RK-U2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00v-0007gh-17
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:26 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de, Ville Syrjala <syrjala@sci.fi>

--===============1849024090==
Content-Disposition: inline; filename=atyfb_improve_atyfb_atari_probe.patch

Improve atyfb_atari_probe():
* Call correct_chipset() so that more par members, par->features in
  particular, get initialized.
* If probe fails iounmap() the mapped regions and continue probing for more
  adapters.

Only verified to cross-compile due to lack of hardware.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -3621,6 +3621,7 @@ static int __init atyfb_atari_probe(void
 	struct fb_info *info;
 	int m64_num;
 	u32 clock_r;
+	int num_found = 0;
 
 	for (m64_num = 0; m64_num < mach64_count; m64_num++) {
 		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
@@ -3668,12 +3669,28 @@ static int __init atyfb_atari_probe(void
 			break;
 		}
 
-		if (aty_init(info)) {
+		/* Fake pci_id for correct_chipset() */
+		switch (aty_ld_le32(CONFIG_CHIP_ID, par) & CFG_CHIP_TYPE) {
+		case 0x00d7:
+			par->pci_id = PCI_CHIP_MACH64GX;
+			break;
+		case 0x0057:
+			par->pci_id = PCI_CHIP_MACH64CX;
+			break;
+		default:
+			break;
+		}
+
+		if (correct_chipset(par) || aty_init(info)) {
+			iounmap(info->screen_base);
+			iounmap(par->ati_regbase);
 			framebuffer_release(info);
-			/* This is insufficient! kernel_map has added two large chunks!! */
-			return -ENXIO;
+		} else {
+			num_found++;
 		}
 	}
+
+	return num_found ? 0 : -ENXIO;
 }
 
 #endif /* CONFIG_ATARI */

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1849024090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1849024090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1849024090==--
