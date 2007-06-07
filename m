From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] fb: epson1355fb: Kill off dead sh
	support.
Date: Thu, 7 Jun 2007 18:54:18 +0900
Message-ID: <20070607095418.GA23002@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwEiN-0005f4-PR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 02:55:35 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwEiN-00071a-FG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 02:55:35 -0700
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

The SH board that was the only user for this code was removed entirely
from the kernel quite some time ago, so there's no reason to leave
the stubs in place. Additionally this driver was completely broken
anyways, so there's not really a lot of point in fixing it up either.

I can't imagine that this driver gets any testing on ARM either, given
that FB_BLANK_UNBLANKING doesn't exist, and kills the build regardless
of which platform is compiling. This fixes that, too.

It wouldn't be a lot of work to finish the platform device conversion
and go with a generic 8-bit read/write_reg and kill off the architecture
dependence completely, should someone have any use for this driver.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/video/Kconfig       |    2 +-
 drivers/video/epson1355fb.c |   16 ++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6e1f1ea..5a6b1cd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -812,7 +812,7 @@ config FB_PVR2
 
 config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
-	depends on (FB = y) && (SUPERH || ARCH_CEIVA)
+	depends on (FB = y) && ARCH_CEIVA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index ca2c54c..5575fa3 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -67,19 +67,7 @@ struct epson1355_par {
 
 /* ------------------------------------------------------------------------- */
 
-#ifdef CONFIG_SUPERH
-
-static inline u8 epson1355_read_reg(int index)
-{
-	return ctrl_inb(par.reg_addr + index);
-}
-
-static inline void epson1355_write_reg(u8 data, int index)
-{
-	ctrl_outb(data, par.reg_addr + index);
-}
-
-#elif defined(CONFIG_ARM)
+#if defined(CONFIG_ARM)
 
 # ifdef CONFIG_ARCH_CEIVA
 #  include <asm/arch/hardware.h>
@@ -289,7 +277,7 @@ static int epson1355fb_blank(int blank_mode, struct fb_info *info)
 	struct epson1355_par *par = info->par;
 
 	switch (blank_mode) {
-	case FB_BLANK_UNBLANKING:
+	case FB_BLANK_UNBLANK:
 	case FB_BLANK_NORMAL:
 		lcd_enable(par, 1);
 		backlight_enable(1);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
