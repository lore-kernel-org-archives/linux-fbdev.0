From: Tom Gundersen <teg@jklm.no>
Date: Sat, 07 Sep 2013 14:08:35 +0000
Subject: [PATCH v3] simplefb: print some info about the registered fb
Message-Id: <1378562915-893-1-git-send-email-teg@jklm.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdXDAA3PgbgNrccStUZGByDXuSsMG_yJMwwUWXwMvyOfsA@mail.gmail.com>
In-Reply-To: <CAMuHMdXDAA3PgbgNrccStUZGByDXuSsMG_yJMwwUWXwMvyOfsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Tom Gundersen <teg@jklm.no>, David Herrmann <dh.herrmann@gmail.com>

This is similar to the output printed by efifb.

Signed-off-by: Tom Gundersen <teg@jklm.no>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
---
v2: also print smem_len, as requested by David
v3: don't cast, as requested by Geert

 drivers/video/simplefb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index a29f1c4..50cbceb 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -220,6 +220,14 @@ static int simplefb_probe(struct platform_device *pdev)
 	}
 	info->pseudo_palette = (void *)(info + 1);
 
+	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
+			     info->fix.smem_start, info->fix.smem_len,
+			     info->screen_base);
+	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
+			     params.format->name,
+			     info->var.xres, info->var.yres,
+			     info->var.bits_per_pixel, info->fix.line_length);
+
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-- 
1.8.4

