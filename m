From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] atyfb: Remove dead code.
Date: Wed,  4 Jun 2008 12:14:21 +0300
Message-ID: <1212570865-31419-3-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
	<1212570865-31419-2-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4k-0008IM-Sz for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:35 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4k-0003Va-Aa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:34 -0700
In-Reply-To: <1212570865-31419-2-git-send-email-syrjala@sci.fi>
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
Cc: Ville Syrjala <syrjala@sci.fi>, akpm@linux-foundation.org, Olaf Hering <olaf@aepfle.de>, adaplas@gmail.com

From: Olaf Hering <olaf@aepfle.de>

Remove dead code. This will slightly change the behaviour of the driver
on systems that support backlight control. Previously they would just
turn the backlight off using the backlight control but now the generic
LCD code will also turn off the LCD using the POWER_MANAGEMENT register.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
Nobody has come forward to test this on one of the affected systems
(ie. pmac laptops that support backlight control) so let's just put it
in. It really shouldn't break anything and it helps if some non-pmac
user has unwittingly configured his kernel with CONFIG_FB_ATY_BACKLIGHT.

 drivers/video/aty/atyfb_base.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index bd4ac0b..d7ba3f1 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2709,8 +2709,7 @@ static int atyfb_blank(int blank, struct fb_info *info)
 	if (par->lock_blank || par->asleep)
 		return 0;
 
-#ifdef CONFIG_FB_ATY_BACKLIGHT
-#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table && blank > FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
 		u32 pm = aty_ld_lcd(POWER_MANAGEMENT, par);
@@ -2739,8 +2738,7 @@ static int atyfb_blank(int blank, struct fb_info *info)
 	}
 	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
 
-#ifdef CONFIG_FB_ATY_BACKLIGHT
-#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table && blank <= FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
 		u32 pm = aty_ld_lcd(POWER_MANAGEMENT, par);
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
