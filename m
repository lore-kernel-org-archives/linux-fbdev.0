From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 4/6] tgafb: Fix the mode register setting
Date: Wed, 13 Dec 2006 17:10:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612131613050.24220@blysk.ds.pg.gda.pl>
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

 There is no need to set the GE bit (Win32 compatibility) in the mode 
register; it shall get cleared with the next subsequent update to the 
register anyway.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 The driver uses a number of magic constants throughout.  The hardware is 
fully documented, so my plan is to fix up them all and provide macros for 
all the used bits and perhaps more once I have finished with updating the 
driver.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-mode-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 05:15:28.000000000 +0000
@@ -136,10 +136,10 @@ tgafb_set_par(struct fb_info *info)
 		0x00000303
 	};
 	static unsigned int const mode_presets[4] = {
-		0x00002000,
-		0x00002300,
+		0x00000000,
+		0x00000300,
 		0xffffffff,
-		0x00002300
+		0x00000300
 	};
 	static unsigned int const base_addr_presets[4] = {
 		0x00000000,
