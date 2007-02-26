From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] atyfb: Fix kconfig error
Date: Tue, 27 Feb 2007 05:52:56 +0800
Message-ID: <45E356B8.8000707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLnkn-0003vq-I7 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 13:51:29 -0800
Received: from wx-out-0506.google.com ([66.249.82.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLnkn-0003eJ-2s
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 13:51:29 -0800
Received: by wx-out-0506.google.com with SMTP id i30so2361616wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 26 Feb 2007 13:51:28 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix the following compile error:

  MODPOST 327 modules
WARNING: "aty_st_lcd" [drivers/video/aty/atyfb.ko] undefined!
WARNING: "aty_ld_lcd" [drivers/video/aty/atyfb.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb_base.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 56b38f5..9ebc4a0 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -131,7 +131,8 @@ #endif
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
+defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
 static const u32 lt_lcd_regs[] = {
 	CONFIG_PANEL_LG,
 	LCD_GEN_CNTL_LG,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
