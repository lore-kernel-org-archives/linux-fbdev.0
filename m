From: Adam Jackson <ajax@redhat.com>
Date: Wed, 15 May 2013 21:04:11 +0000
Subject: [PATCH] video: Use less worrisome language in fbdev handoff
Message-Id: <1368651851-14326-1-git-send-email-ajax@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

For some reason people see "conflicting" and think it's a problem, even
though it's totally normal.  Just call it a handoff.

Signed-off-by: Adam Jackson <ajax@redhat.com>
---
 drivers/video/fbmem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 098bfc6..2ec56a2 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1576,10 +1576,9 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 		if (fb_do_apertures_overlap(gen_aper, a) ||
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base = VGA_FB_PHYS)) {
-
-			printk(KERN_INFO "fb: conflicting fb hw usage "
-			       "%s vs %s - removing generic driver\n",
-			       name, registered_fb[i]->fix.id);
+			printk(KERN_INFO "fb: Handoff from generic %s "
+			       "driver to %s\n", registered_fb[i]->fix.id,
+			       name);
 			do_unregister_framebuffer(registered_fb[i]);
 		}
 	}
-- 
1.8.2.1

