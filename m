From: Denis Carikli <denis@eukrea.com>
Date: Wed, 22 Jan 2014 17:09:35 +0000
Subject: [PATCHv14][ 2/4] video: imxfb: Add DT default contrast control register property.
Message-Id: <1390410577-22073-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
ChangeLog v5->v14:
- Remove people not concerned by this patch from the Cc list.
- Changed the property name to match the register name and function.
- Updated the documentation, code and commit message accordingly.
---
 .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
 drivers/video/imxfb.c                              |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Docum=
entation/devicetree/bindings/video/fsl,imx-fb.txt
index 46da08d..a2a19cb 100644
--- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
@@ -17,6 +17,9 @@ Required nodes:
 Optional properties:
 - fsl,dmacr: DMA Control Register value. This is optional. By default, the
 	register is not modified as recommended by the datasheet.
+- fsl,lpccr: Contrast Control Register value. This property provides the
+	default value for the contrast control register.
+	If that property is ommited, the register is zeroed.
 - fsl,lscr1: LCDC Sharp Configuration Register value.
=20
 Example:
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index dd8a35d..c55991a 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -818,6 +818,8 @@ static int imxfb_init_fbinfo(struct platform_device *pd=
ev)
=20
 		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
=20
+		of_property_read_u32(np, "fsl,lpccr", &fbi->pwmr);
+
 		/* These two function pointers could be used by some specific
 		 * platforms. */
 		fbi->lcd_power =3D NULL;
--=20
1.7.9.5

