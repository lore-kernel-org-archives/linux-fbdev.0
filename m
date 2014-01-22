From: Denis Carikli <denis@eukrea.com>
Date: Wed, 22 Jan 2014 17:09:36 +0000
Subject: [PATCHv14][ 3/4] video: Kconfig: Allow more broad selection of the imxfb framebuffer driver.
Message-Id: <1390410577-22073-3-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1390410577-22073-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Without that patch, a user can't select the imxfb driver when the i.MX25 an=
d/or
  the i.MX27 device tree board are selected and that no boards that selects
  IMX_HAVE_PLATFORM_IMX_FB are compiled in.

Cc: Eric B=C3=A9nard <eric@eukrea.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
ChangeLog v11->v14:
- Remove people not concerned by this patch from the Cc list.

ChangeLog v10->v11:
- moved my signed-off-by.

ChangeLog v8->v9:
- Added Jean-Christophe PLAGNIOL-VILLARD's ACK.
---
 drivers/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 22262a3..dade5b7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -364,7 +364,7 @@ config FB_SA1100
=20
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	depends on FB && ARCH_MXC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--=20
1.7.9.5

