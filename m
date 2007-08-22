From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] au1100fb: move au1100fb_fb_blank()
 beforce au1100fb_setmode()
Date: Wed, 22 Aug 2007 13:14:19 +0900
Message-ID: <200708220414.l7M4EJcI002322@po-mbox301.hop.2iij.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INhdE-0006P9-9M for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 21:15:48 -0700
Received: from mo30.po.2iij.net ([210.128.50.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1INhdB-0000a7-N4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 21:15:48 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>

au1100fb_fb_blank() should come before au1100fb_setmode().

drivers/video/au1100fb.c: In function 'au1100fb_setmode':
drivers/video/au1100fb.c:211: error: implicit declaration of function 'au1100fb_fb_blank'

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/video/au1100fb.c generic/drivers/video/au1100fb.c
--- generic-orig/drivers/video/au1100fb.c	2007-08-09 15:35:14.040257250 +0900
+++ generic/drivers/video/au1100fb.c	2007-08-09 15:47:05.244704750 +0900
@@ -115,6 +115,52 @@ static int nocursor = 0;
 module_param(nocursor, int, 0644);
 MODULE_PARM_DESC(nocursor, "cursor enable/disable");
 
+/* fb_blank
+ * Blank the screen. Depending on the mode, the screen will be
+ * activated with the backlight color, or desactivated
+ */
+static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
+{
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+
+	print_dbg("fb_blank %d %p", blank_mode, fbi);
+
+	switch (blank_mode) {
+
+	case VESA_NO_BLANKING:
+			/* Turn on panel */
+			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
+#ifdef CONFIG_MIPS_PB1100
+			if (drv_info.panel_idx == 1) {
+				au_writew(au_readw(PB1100_G_CONTROL)
+					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+			PB1100_G_CONTROL);
+			}
+#endif
+		au_sync();
+		break;
+
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+	case VESA_POWERDOWN:
+			/* Turn off panel */
+			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
+#ifdef CONFIG_MIPS_PB1100
+			if (drv_info.panel_idx == 1) {
+				au_writew(au_readw(PB1100_G_CONTROL)
+				  	  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+			PB1100_G_CONTROL);
+			}
+#endif
+		au_sync();
+		break;
+	default:
+		break;
+
+	}
+	return 0;
+}
+
 /*
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
@@ -272,52 +318,6 @@ int au1100fb_fb_setcolreg(unsigned regno
 	return 0;
 }
 
-/* fb_blank
- * Blank the screen. Depending on the mode, the screen will be
- * activated with the backlight color, or desactivated
- */
-int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
-{
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
-
-	print_dbg("fb_blank %d %p", blank_mode, fbi);
-
-	switch (blank_mode) {
-
-	case VESA_NO_BLANKING:
-			/* Turn on panel */
-			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
-#ifdef CONFIG_MIPS_PB1100
-			if (drv_info.panel_idx == 1) {
-				au_writew(au_readw(PB1100_G_CONTROL)
-					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
-			PB1100_G_CONTROL);
-			}
-#endif
-		au_sync();
-		break;
-
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	case VESA_POWERDOWN:
-			/* Turn off panel */
-			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
-#ifdef CONFIG_MIPS_PB1100
-			if (drv_info.panel_idx == 1) {
-				au_writew(au_readw(PB1100_G_CONTROL)
-				  	  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
-			PB1100_G_CONTROL);
-			}
-#endif
-		au_sync();
-		break;
-	default:
-		break;
-
-	}
-	return 0;
-}
-
 /* fb_pan_display
  * Pan display in x and/or y as specified
  */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
