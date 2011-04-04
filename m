From: Matthew Garrett <mjg@redhat.com>
Date: Mon, 04 Apr 2011 21:39:54 +0000
Subject: [PATCH] fb: Reduce priority of resource conflict message
Message-Id: <1301953194-6706-1-git-send-email-mjg@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It's expected that efifb will conflict with a native driver, so the
handover message should be informational rather than an error.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index e2bf953..e0c2284 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1507,7 +1507,7 @@ void remove_conflicting_framebuffers(struct apertures_struct *a,
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base = VGA_FB_PHYS)) {
 
-			printk(KERN_ERR "fb: conflicting fb hw usage "
+			printk(KERN_INFO "fb: conflicting fb hw usage "
 			       "%s vs %s - removing generic driver\n",
 			       name, registered_fb[i]->fix.id);
 			unregister_framebuffer(registered_fb[i]);
-- 
1.7.4.1

