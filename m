From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Thu, 16 Jun 2011 19:32:40 +0000
Subject: [PATCH] sm501fb: fix section mismatch warning
Message-Id: <20110616123240.ecd25243.randy.dunlap@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix section mismatch warning in sm501fb:

WARNING: drivers/video/sm501fb.o(.text+0x21d6): Section mismatch in reference from the function sm501fb_init_fb() to the variable .devinit.data:sm501_default_mode
The function sm501fb_init_fb() references
the variable __devinitdata sm501_default_mode.
This is often because sm501fb_init_fb lacks a __devinitdata 
annotation or the annotation of sm501_default_mode is wrong.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/sm501fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-30-rc3.orig/drivers/video/sm501fb.c
+++ lnx-30-rc3/drivers/video/sm501fb.c
@@ -1664,7 +1664,7 @@ static void sm501fb_stop(struct sm501fb_
 			   resource_size(info->regs_res));
 }
 
-static int sm501fb_init_fb(struct fb_info *fb,
+static int __devinit sm501fb_init_fb(struct fb_info *fb,
 			   enum sm501_controller head,
 			   const char *fbname)
 {
