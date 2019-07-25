From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 25 Jul 2019 18:38:56 +0000
Subject: [PATCH] Staging: fbtft: Fix some typo. pdc8544 --> pcd8544
Message-Id: <20190725183856.17616-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, nishadkamdar@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The driver is related to 'pcd8544'.
However, 2 strings are about pdc8544 (c and d switched)
Fix it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only theorical. It is based on the fact that a part of the
filename (i.e. pcd8544) looks misspelled in the file itself.
I don't know the implication of FBTFT_REGISTER_DRIVER and MODULE_ALIAS and
if additional adjustments are needed.
---
 drivers/staging/fbtft/fb_pcd8544.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/fb_pcd8544.c
index ad49973ad594..08f8a4bb8772 100644
--- a/drivers/staging/fbtft/fb_pcd8544.c
+++ b/drivers/staging/fbtft/fb_pcd8544.c
@@ -157,10 +157,10 @@ static struct fbtft_display display = {
 	.backlight = 1,
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pdc8544", &display);
+FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pcd8544", &display);
 
 MODULE_ALIAS("spi:" DRVNAME);
-MODULE_ALIAS("spi:pdc8544");
+MODULE_ALIAS("spi:pcd8544");
 
 MODULE_DESCRIPTION("FB driver for the PCD8544 LCD Controller");
 MODULE_AUTHOR("Noralf Tronnes");
-- 
2.20.1
