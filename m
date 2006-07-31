From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/13] au1100fb: Fix startup sequence
Date: Tue, 01 Aug 2006 07:27:03 +0800
Message-ID: <44CE91C7.5070807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOF-000385-G5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:41 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOF-0004Mn-7l
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:39 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:39 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Rodolfo Giometti <giometti@linux.it>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Rodolfo Giometti <giometti@linux.it>

- fix up the start up sequence.

This new sequence allow you to correctly enable the LCD controller
even if the bootloader has already did it.

- fix up a wrong indentation issue.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index ef221cc..ef5c16f 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -161,7 +161,7 @@ int au1100fb_setmode(struct au1100fb_dev
 
 			info->fix.visual = FB_VISUAL_TRUECOLOR;
 			info->fix.line_length = info->var.xres_virtual << 1; /* depth=16 */
-	}
+		}
 	} else {
 		/* mono */
 		info->fix.visual = FB_VISUAL_MONO10;
@@ -174,16 +174,11 @@ int au1100fb_setmode(struct au1100fb_dev
 
 	/* Determine BPP mode and format */
 	fbdev->regs->lcd_control = fbdev->panel->control_base;
-
-	fbdev->regs->lcd_intenable = 0;
-	fbdev->regs->lcd_intstatus = 0;
-
 	fbdev->regs->lcd_horztiming = fbdev->panel->horztiming;
-
 	fbdev->regs->lcd_verttiming = fbdev->panel->verttiming;
-
 	fbdev->regs->lcd_clkcontrol = fbdev->panel->clkcontrol_base;
-
+	fbdev->regs->lcd_intenable = 0;
+	fbdev->regs->lcd_intstatus = 0;
 	fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(fbdev->fb_phys);
 
 	if (panel_is_dual(fbdev->panel)) {
@@ -212,6 +207,8 @@ int au1100fb_setmode(struct au1100fb_dev
 
 	/* Resume controller */
 	fbdev->regs->lcd_control |= LCD_CONTROL_GO;
+	mdelay(10);
+	au1100fb_fb_blank(VESA_NO_BLANKING, info);
 
 	return 0;
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
