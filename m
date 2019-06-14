From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Jun 2019 11:53:52 +0000
Subject: [PATCH] video: fbdev: imxfb: fix sparse warnings about using incorrect types
Message-Id: <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
 <CGME20190614115350eucas1p282c9670fc70fad90d3406013e9105106@eucas1p2.samsung.com>
In-Reply-To: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kbuild test robot <lkp@intel.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/imxfb.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: b/drivers/video/fbdev/imxfb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -974,9 +974,8 @@ static int imxfb_probe(struct platform_d
 	}
=20
 	fbi->map_size =3D PAGE_ALIGN(info->fix.smem_len);
-	info->screen_base =3D dma_alloc_wc(&pdev->dev, fbi->map_size,
-					 &fbi->map_dma, GFP_KERNEL);
-
+	info->screen_buffer =3D dma_alloc_wc(&pdev->dev, fbi->map_size,
+					   &fbi->map_dma, GFP_KERNEL);
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret =3D -ENOMEM;
@@ -1046,7 +1045,7 @@ failed_cmap:
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
 failed_platform_init:
-	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
 failed_map:
 	iounmap(fbi->regs);
@@ -1077,7 +1076,7 @@ static int imxfb_remove(struct platform_
 	pdata =3D dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
-	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
