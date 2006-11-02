From: akpm@osdl.org
Subject: [patch 24/25] atyfb: Improve atyfb_atari_probe()
Date: Wed, 01 Nov 2006 21:50:34 -0800
Message-ID: <200611020550.kA25oYMW002360@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTc-0007aE-CK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:56 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTb-0007KF-W5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:56 -0800
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
Cc: akpm@osdl.org, adaplas@pol.net, syrjala@sci.fi

From: Ville Syrjala <syrjala@sci.fi>

Improve atyfb_atari_probe():
* Call correct_chipset() so that more par members, par->features in
  particular, get initialized.
* If probe fails iounmap() the mapped regions and continue probing for more
  adapters.

Only verified to cross-compile due to lack of hardware.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/atyfb_base.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~atyfb-improve-atyfb_atari_probe drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c~atyfb-improve-atyfb_atari_probe
+++ a/drivers/video/aty/atyfb_base.c
@@ -3629,6 +3629,7 @@ static int __init atyfb_atari_probe(void
 	struct fb_info *info;
 	int m64_num;
 	u32 clock_r;
+	int num_found = 0;
 
 	for (m64_num = 0; m64_num < mach64_count; m64_num++) {
 		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
@@ -3676,16 +3677,28 @@ static int __init atyfb_atari_probe(void
 			break;
 		}
 
-		if (aty_init(info)) {
-			if (info->screen_base)
-				iounmap(info->screen_base);
-			if (par->ati_regbase)
-				iounmap(par->ati_regbase);
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
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
