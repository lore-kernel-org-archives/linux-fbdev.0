From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/13] au1100fb: info->var.rotate fix
Date: Tue, 01 Aug 2006 07:24:59 +0800
Message-ID: <44CE914B.2010604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hNi-00036x-Q0 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:06 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hNf-0002Zh-Qd
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:05 -0700
Received: by ug-out-1314.google.com with SMTP id s2so1007584uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:02 -0700 (PDT)
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

Fix "info->var.rotate" data settings.

This info should be deduced directly from "fbdev->panel->control_base"
defined into au1100fb.h.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index a92a91f..26086bf 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -164,10 +164,11 @@ int au1100fb_setmode(struct au1100fb_dev
 	}
 
 	info->screen_size = info->fix.line_length * info->var.yres_virtual;
+	info->var.rotate = ((fbdev->panel->control_base&LCD_CONTROL_SM_MASK) \
+				>> LCD_CONTROL_SM_BIT) * 90;
 
 	/* Determine BPP mode and format */
-	fbdev->regs->lcd_control = fbdev->panel->control_base |
-			    ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
+	fbdev->regs->lcd_control = fbdev->panel->control_base;
 
 	fbdev->regs->lcd_intenable = 0;
 	fbdev->regs->lcd_intstatus = 0;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
