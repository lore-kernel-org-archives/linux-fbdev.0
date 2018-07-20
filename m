From: Colin King <colin.king@canonical.com>
Date: Fri, 20 Jul 2018 18:52:13 +0000
Subject: [PATCH] omapfb: encoder-tpd12s015: remove redundant pointer 'in'
Message-Id: <20180720185213.3085-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'in' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'in' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c    | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 8abf973a59db..47f0459e3551 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -219,7 +219,7 @@ static int tpd_probe_of(struct platform_device *pdev)
 
 static int tpd_probe(struct platform_device *pdev)
 {
-	struct omap_dss_device *in, *dssdev;
+	struct omap_dss_device *dssdev;
 	struct panel_drv_data *ddata;
 	int r;
 	struct gpio_desc *gpio;
@@ -238,7 +238,6 @@ static int tpd_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
 		GPIOD_OUT_LOW);
 	if (IS_ERR(gpio)) {
@@ -274,8 +273,6 @@ static int tpd_probe(struct platform_device *pdev)
 	dssdev->owner = THIS_MODULE;
 	dssdev->port_num = 1;
 
-	in = ddata->in;
-
 	r = omapdss_register_output(dssdev);
 	if (r) {
 		dev_err(&pdev->dev, "Failed to register output\n");
-- 
2.17.1

