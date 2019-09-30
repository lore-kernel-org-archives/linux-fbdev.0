From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 30 Sep 2019 03:09:45 +0000
Subject: [PATCH] Staging: fbtft: fix memory leak in fbtft_framebuffer_alloc
Message-Id: <20190930030949.28615-1-navid.emamdoost@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.net>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, emamd001@umn.edu, Bhanusree Pola <bhanusreemahesh@gmail.com>, smccaman@umn.edu, Phil Reid <preid@electromag.com.au>, Sam Ravnborg <sam@ravnborg.org>, Navid Emamdoost <navid.emamdoost@gmail.com>

In fbtft_framebuffer_alloc the error handling path should take care of
releasing frame buffer after it is allocated via framebuffer_alloc, too.
Therefore, in two failure cases the goto destination is changed to
address this issue.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index cf5700a2ea66..a0a67aa517f0 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -714,7 +714,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto alloc_fail;
+			goto release_framebuf;
 	}
 
 	/* Transmit buffer */
@@ -731,7 +731,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto alloc_fail;
+			goto release_framebuf;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -753,6 +753,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+release_framebuf:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 
-- 
2.17.1
