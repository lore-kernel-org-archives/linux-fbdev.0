From: Andy Lutomirski <luto@MIT.EDU>
Date: Thu, 26 May 2011 14:13:31 +0000
Subject: [PATCH 1/4] efifb: Enable write-combining
Message-Id: <3647a3cc4157f8c50ab719f1a7500e695cf66a05.1306418703.git.luto@mit.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Running fbcon on an uncached framebuffer is remarkably slow.  So try
to enable write combining in efifb.

Without this patch, it takes 5.8 seconds from efifb probe to i915
probe (default options; no plymouth or quiet mode).  With this patch,
it only takes 1.7 seconds.  That means we wasted over 4 seconds just
writing to UC memory.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 drivers/video/efifb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 4eb38db..a81c944 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -413,7 +413,7 @@ static int __devinit efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
+	info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR "efifb: abort, cannot ioremap video memory "
 				"0x%x @ 0x%lx\n",
-- 
1.7.5.1

