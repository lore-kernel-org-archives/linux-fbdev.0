From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Mon, 06 Jan 2014 13:17:57 +0000
Subject: [PATCH 1/2] video: mxsfb: convert pr_debug()/dev_dbg() to pr_err()/dev_err() for error messages
Message-Id: <1389014278-4903-2-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Make the messages that are printed in case of fatal errors actually
visible to the user without having to recompile the driver with
debugging enabled.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/mxsfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 27197a8..d11c35c 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -297,7 +297,7 @@ static int mxsfb_check_var(struct fb_var_screeninfo *va=
r,
 		}
 		break;
 	default:
-		pr_debug("Unsupported colour depth: %u\n", var->bits_per_pixel);
+		pr_err("Unsupported colour depth: %u\n", var->bits_per_pixel);
 		return -EINVAL;
 	}
=20
@@ -426,7 +426,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		ctrl |=3D CTRL_SET_WORD_LENGTH(3);
 		switch (host->ld_intf_width) {
 		case STMLCDIF_8BIT:
-			dev_dbg(&host->pdev->dev,
+			dev_err(&host->pdev->dev,
 					"Unsupported LCD bus width mapping\n");
 			return -EINVAL;
 		case STMLCDIF_16BIT:
@@ -439,7 +439,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		writel(CTRL1_SET_BYTE_PACKAGING(0x7), host->base + LCDC_CTRL1);
 		break;
 	default:
-		dev_dbg(&host->pdev->dev, "Unhandled color depth of %u\n",
+		dev_err(&host->pdev->dev, "Unhandled color depth of %u\n",
 				fb_info->var.bits_per_pixel);
 		return -EINVAL;
 	}
--=20
1.7.2.5

