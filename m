From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Thu, 22 Nov 2012 12:49:14 +0000
Subject: [BUGFIX PATCH] video: mxsfb: fix crash when unblanking the display
Message-Id: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
The write in mxsfb_disable_controller() sets the data_cnt for the LCD
DMA to 0 which obviously means the max. count for the LCD DMA and
leads to overwriting arbitrary memory when the display is unblanked.

Note: I already sent this patch in December 2011 but noone picked it up obv=
iously.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/mxsfb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 49619b4..f2a49ef 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -369,7 +369,8 @@ static void mxsfb_disable_controller(struct fb_info *fb=
_info)
 		loop--;
 	}
=20
-	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
+	reg =3D readl(host->base + LCDC_VDCTRL4);
+	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
=20
 	clk_disable_unprepare(host->clk);
=20
--=20
1.7.2.5

