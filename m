From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:54:50 +0000
Subject: [PATCH 10/11] viafb: probe cleanups
Message-Id: <1279900490-4488-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: probe cleanups

Removal of strange special cases that must not exist as well as a
useless check.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/viafbdev.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 1128d51..0f56eb2 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1525,10 +1525,6 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 	parse_lcd_port();
 	parse_dvi_port();
 
-	/* for dual-fb must viafb_SAMM_ON=1 and viafb_dual_fb=1 */
-	if (!viafb_SAMM_ON)
-		viafb_dual_fb = 0;
-
 	viafb_init_chip_info(vdev->chip_type);
 	/*
 	 * The framebuffer will have been successfully mapped by
@@ -1572,30 +1568,13 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 		parse_mode(viafb_mode1, &viafb_second_xres,
 			&viafb_second_yres);
 
-		if (0 = viafb_second_virtual_xres) {
-			switch (viafb_second_xres) {
-			case 1400:
-				viafb_second_virtual_xres = 1408;
-				break;
-			default:
-				viafb_second_virtual_xres = viafb_second_xres;
-				break;
-			}
-		}
-		if (0 = viafb_second_virtual_yres)
-			viafb_second_virtual_yres = viafb_second_yres;
+		viafb_second_virtual_xres = viafb_second_xres;
+		viafb_second_virtual_yres = viafb_second_yres;
 	}
 
 	default_var.xres = default_xres;
 	default_var.yres = default_yres;
-	switch (default_xres) {
-	case 1400:
-		default_var.xres_virtual = 1408;
-		break;
-	default:
-		default_var.xres_virtual = default_xres;
-		break;
-	}
+	default_var.xres_virtual = default_xres;
 	default_var.yres_virtual = default_yres;
 	default_var.bits_per_pixel = viafb_bpp;
 	default_var.pixclock -- 
1.6.3.2

