From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 11 May 2016 23:57:47 +0000
Subject: [PATCH] efifb: Don't show the mapping VA
Message-Id: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Andy Lutomirski <luto@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The framebuffer mapping virtual address leaks information about the
kernel memory layout.  Stop logging it.

Cc: Peter Jones <pjones@redhat.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/video/fbdev/efifb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 95d293b7445a..3dcaf4e82885 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -247,10 +247,8 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_release_fb;
 	}
 
-	printk(KERN_INFO "efifb: framebuffer at 0x%lx, mapped to 0x%p, "
-	       "using %dk, total %dk\n",
-	       efifb_fix.smem_start, info->screen_base,
-	       size_remap/1024, size_total/1024);
+	printk(KERN_INFO "efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
+	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
 	printk(KERN_INFO "efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       efifb_defined.xres, efifb_defined.yres,
 	       efifb_defined.bits_per_pixel, efifb_fix.line_length,
-- 
2.5.5

