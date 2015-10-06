From: Lars Svensson <lars1.svensson@sonymobile.com>
Date: Tue, 06 Oct 2015 07:02:06 +0000
Subject: [PATCH 2/2] staging: fbtft: fix sparse warning in call to vfree()
Message-Id: <1444114926-18000-2-git-send-email-lars1.svensson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444114926-18000-1-git-send-email-lars1.svensson@sonymobile.com>
In-Reply-To: <1444114926-18000-1-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, Lars Svensson <lars1.svensson@sonymobile.com>

Member screen_base in struct fb_info is declared __iomem causing
a sparse warning as below when passed to vfree(). Instead use non-
__iomem pointer screen_buffer to avoid the warning.

fbtft-core.c:922:39: warning: incorrect type in argument 1 \
(different address spaces)
fbtft-core.c:922:39:    expected void const *addr
fbtft-core.c:922:39:    got char [noderef] <asn:2>*screen_base

Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 7f5fa3d..a5fade2 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -779,7 +779,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (!info)
 		goto alloc_fail;
 
-	info->screen_base = (u8 __force __iomem *)vmem;
+	info->screen_buffer = vmem;
 	info->fbops = fbops;
 	info->fbdefio = fbdefio;
 
@@ -919,7 +919,7 @@ EXPORT_SYMBOL(fbtft_framebuffer_alloc);
 void fbtft_framebuffer_release(struct fb_info *info)
 {
 	fb_deferred_io_cleanup(info);
-	vfree(info->screen_base);
+	vfree(info->screen_buffer);
 	framebuffer_release(info);
 }
 EXPORT_SYMBOL(fbtft_framebuffer_release);
-- 
2.4.2

