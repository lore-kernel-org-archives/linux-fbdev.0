From: Daniel J Blueman <daniel.blueman@gmail.com>
Date: Mon, 27 Jun 2011 23:08:53 +0000
Subject: [PATCH] vesafb: fix memory leak
Message-Id: <1309216133-3118-1-git-send-email-daniel.blueman@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel.blueman@gmail.com>

When releasing framebuffer, free colourmap allocations.

Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>
---
 drivers/video/vesafb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index a99bbe8..501b340 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -175,6 +175,7 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static void vesafb_destroy(struct fb_info *info)
 {
+	fb_dealloc_cmap(&info->cmap);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
-- 
1.7.4.1

