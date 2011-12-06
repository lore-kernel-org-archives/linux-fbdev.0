From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Tue, 06 Dec 2011 12:27:05 +0000
Subject: [BUGFIX] video/mxsfb: fix crash when unblanking the display
Message-Id: <1323174425-24038-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
The write in mxsfb_disable_controller() sets the data_cnt for the LCD
DMA to 0 which obviously means the max. count for the LCD DMA and
leads to overwriting arbitrary memory when the display is unblanked.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/mxsfb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index d837d63..03cb95a 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -366,7 +366,8 @@ static void mxsfb_disable_controller(struct fb_info *fb=
_info)
 		loop--;
 	}
=20
-	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
+	reg =3D readl(host->base + LCDC_VDCTRL4);
+	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
=20
 	clk_disable(host->clk);
=20
--=20
1.5.6.5

