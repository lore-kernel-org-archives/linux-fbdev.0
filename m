From: Andy Lutomirski <luto@MIT.EDU>
Date: Thu, 26 May 2011 14:13:33 +0000
Subject: [PATCH 3/4] efifb: Fix an integer-to-pointer size warning
Message-Id: <0c405ceeca72c92d25cb6ee4bc92c35d2cb15019.1306418703.git.luto@mit.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 drivers/video/efifb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 43af770..39bbfa9 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -246,8 +246,9 @@ static int set_system(const struct dmi_system_id *id)
 
 	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at %p "
 			 "(%dx%d, stride %d)\n", id->ident,
-			 (void *)screen_info.lfb_base, screen_info.lfb_width,
-			 screen_info.lfb_height, screen_info.lfb_linelength);
+			 (void *)(unsigned long)screen_info.lfb_base,
+			 screen_info.lfb_width, screen_info.lfb_height,
+			 screen_info.lfb_linelength);
 
 
 	return 1;
-- 
1.7.5.1

