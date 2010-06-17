From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Date: Thu, 17 Jun 2010 18:59:05 +0000
Subject: [PATCH] video/imxfb: fix suspend when screen is blanked
Message-Id: <1276801147-4103-5-git-send-email-eric@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
	<1276801147-4103-3-git-send-email-eric@eukrea.com>
	<1276801147-4103-4-git-send-email-eric@eukrea.com>
In-Reply-To: <1276801147-4103-4-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

if the screen is blanked when suspending, the clock is already disabled,
leading to the following log :
WARNING: at arch/arm/plat-mxc/clock.c:59 __clk_disable+0x68/0x74()
Modules linked in:
[<c002d200>] (unwind_backtrace+0x0/0xf8) from [<c0046008>] (warn_slowpath_c=
ommon+0x48/0x78)
[<c0046008>] (warn_slowpath_common+0x48/0x78) from [<c0031e28>] (__clk_disa=
ble+0x68/0x74)
[<c0031e28>] (__clk_disable+0x68/0x74) from [<c0031ddc>] (__clk_disable+0x1=
c/0x74)
[<c0031ddc>] (__clk_disable+0x1c/0x74) from [<c0031e58>] (clk_disable+0x24/=
0x34)
[<c0031e58>] (clk_disable+0x24/0x34) from [<c019808c>] (imxfb_disable_contr=
oller+0x38/0x48)
[<c019808c>] (imxfb_disable_controller+0x38/0x48) from [<c01980b0>] (imxfb_=
suspend+0x14/0x1c)

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Cc: kernel@pengutronix.de
Cc: u.kleine-koenig@pengutronix.de
Cc: linux-fbdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/imxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index b4b6dec..6cbfbff 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -597,8 +597,8 @@ static int imxfb_suspend(struct platform_device *dev, p=
m_message_t state)
 	struct imxfb_info *fbi =3D info->par;
=20
 	pr_debug("%s\n", __func__);
-
-	imxfb_disable_controller(fbi);
+	if (readl(fbi->regs + LCDC_RMCR))
+		imxfb_disable_controller(fbi);
 	return 0;
 }
=20
--=20
1.6.3.3

