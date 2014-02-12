From: Adam Jackson <ajax@redhat.com>
Date: Wed, 12 Feb 2014 21:02:02 +0000
Subject: [PATCH] fbdev: Make the switch from generic to native driver less alarming
Message-Id: <1392238922-28255-1-git-send-email-ajax@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345223444-15852-1-git-send-email-ajax@redhat.com>
In-Reply-To: <1345223444-15852-1-git-send-email-ajax@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Calling this "conflicting" just makes people think there's a problem
when there's not.

Signed-off-by: Adam Jackson <ajax@redhat.com>
---
 drivers/video/fbmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7309ac7..b6d5008 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1596,8 +1596,7 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base = VGA_FB_PHYS)) {
 
-			printk(KERN_INFO "fb: conflicting fb hw usage "
-			       "%s vs %s - removing generic driver\n",
+			printk(KERN_INFO "fb: switching to %s from %s\n",
 			       name, registered_fb[i]->fix.id);
 			ret = do_unregister_framebuffer(registered_fb[i]);
 			if (ret)
-- 
1.8.5.3

