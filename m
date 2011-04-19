From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date: Tue, 19 Apr 2011 09:47:15 +0000
Subject: [PATCH] efifb: fix int to pointer cast warning
Message-Id: <20110419094715.7888.84515.stgit@localhost6>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

drivers/video/efifb.c:247: warning: cast to pointer from integer of different size

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
---
 drivers/video/efifb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 4eb38db..fb20584 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -242,9 +242,9 @@ static int set_system(const struct dmi_system_id *id)
 		return 0;
 	}
 
-	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at %p "
+	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at 0x%08x "
 			 "(%dx%d, stride %d)\n", id->ident,
-			 (void *)screen_info.lfb_base, screen_info.lfb_width,
+			 screen_info.lfb_base, screen_info.lfb_width,
 			 screen_info.lfb_height, screen_info.lfb_linelength);
 
 

