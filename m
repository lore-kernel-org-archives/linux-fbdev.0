From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Sat, 13 Feb 2010 10:41:48 +0000
Subject: [PATCH] efifb: fix framebuffer handoff
Message-Id: <20100213104148.GB2880@joi.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100210195530.GA29558@joi.lan>
In-Reply-To: <20100210195530.GA29558@joi.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, Dave Airlie <airlied@redhat.com>, Huang Ying <ying.huang@intel.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alex Zhavnerchik <alex.vizor@gmail.com>

Commit 4410f3910947dcea8672280b3adecd53cec4e85e
(fbdev: add support for handoff from firmware to hw framebuffers)
didn't add fb_destroy operation to efifb. Fix it and change
aperture_size to match size passed to request_mem_region.

See: http://bugzilla.kernel.org/show_bug.cgi?id151

Reported-by: Alex Zhavnerchik <alex.vizor@gmail.com>
Tested-by: Alex Zhavnerchik <alex.vizor@gmail.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
---
 drivers/video/efifb.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index eb12182..d25df51 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -161,8 +161,17 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return 0;
 }
 
+static void efifb_destroy(struct fb_info *info)
+{
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(info->aperture_base, info->aperture_size);
+	framebuffer_release(info);
+}
+
 static struct fb_ops efifb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_destroy	= efifb_destroy,
 	.fb_setcolreg	= efifb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -281,7 +290,7 @@ static int __init efifb_probe(struct platform_device *dev)
 	info->par = NULL;
 
 	info->aperture_base = efifb_fix.smem_start;
-	info->aperture_size = size_total;
+	info->aperture_size = size_remap;
 
 	info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
 	if (!info->screen_base) {
-- 
1.6.6

