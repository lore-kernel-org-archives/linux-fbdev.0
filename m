From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 6/6] tgafb: Sync-on-green support fixes
Date: Wed, 13 Dec 2006 17:10:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612131623360.24220@blysk.ds.pg.gda.pl>
Reply-To: Linux on Alpha processors <axp-list@redhat.com>
Mime-Version: 1.0
Return-path: <axp-list-bounces@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/axp-list>
List-Post: <mailto:axp-list@redhat.com>
List-Help: <mailto:axp-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=subscribe>
Sender: axp-list-bounces@redhat.com
Errors-To: axp-list-bounces@redhat.com
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: axp-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 This sets up the deep register of the TGA ASIC as well as the blank 
pedestal of the Bt463 RAMDAC correctly for the sync-on-green mode.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-sync_on_green-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 14:32:20.000000000 +0000
@@ -189,7 +189,9 @@ tgafb_set_par(struct fb_info *info)
 	while (TGA_READ_REG(par, TGA_CMD_STAT_REG) & 1) /* wait for not busy */
 		continue;
 	mb();
-	TGA_WRITE_REG(par, deep_presets[tga_type], TGA_DEEP_REG);
+	TGA_WRITE_REG(par, deep_presets[tga_type] |
+			   (par->sync_on_green ? 0x0 : 0x00010000),
+		      TGA_DEEP_REG);
 	while (TGA_READ_REG(par, TGA_CMD_STAT_REG) & 1) /* wait for not busy */
 		continue;
 	mb();
@@ -248,11 +250,11 @@ tgafb_set_par(struct fb_info *info)
 
 	} else { /* 24-plane or 24plusZ */
 
-		/* Init BT463 registers.  */
+		/* Init BT463 RAMDAC registers.  */
 		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_0, 0x40);
 		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_1, 0x08);
 		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_2,
-			    (par->sync_on_green ? 0x80 : 0x40));
+			    (par->sync_on_green ? 0xc0 : 0x40));
 
 		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_0, 0xff);
 		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_1, 0xff);
