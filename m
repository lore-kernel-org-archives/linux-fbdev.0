From: Colin King <colin.king@canonical.com>
Date: Wed, 05 Aug 2020 10:28:05 +0000
Subject: [PATCH] omapfb: fix spelling mistake "propert" -> "property"
Message-Id: <20200805102805.15353-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/venc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
index 0b0ad20afd63..f560fa4d7786 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
@@ -787,7 +787,7 @@ static int venc_probe_of(struct platform_device *pdev)
 		venc.type = OMAP_DSS_VENC_TYPE_SVIDEO;
 		break;
 	default:
-		dev_err(&pdev->dev, "bad channel propert '%d'\n", channels);
+		dev_err(&pdev->dev, "bad channel property '%d'\n", channels);
 		r = -EINVAL;
 		goto err;
 	}
-- 
2.27.0
