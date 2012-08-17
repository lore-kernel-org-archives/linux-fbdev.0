From: Adam Jackson <ajax@redhat.com>
Date: Fri, 17 Aug 2012 17:10:44 +0000
Subject: [PATCH] fbdev: Make the switch from generic to native driver less alarming
Message-Id: <1345223444-15852-1-git-send-email-ajax@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Calling this "conflicting" just makes people think there's a problem
when there's not.

Signed-off-by: Adam Jackson <ajax@redhat.com>
---
 drivers/video/fbmem.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 0dff12a..42be978 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1582,8 +1582,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base = VGA_FB_PHYS)) {
 
-			printk(KERN_INFO "fb: conflicting fb hw usage "
-			       "%s vs %s - removing generic driver\n",
+			printk(KERN_INFO "fb: switching to %s from %s\n",
 			       name, registered_fb[i]->fix.id);
 			do_unregister_framebuffer(registered_fb[i]);
 		}
-- 
1.7.7.6

