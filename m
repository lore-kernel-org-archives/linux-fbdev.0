From: Denis Carikli <denis@eukrea.com>
Date: Fri, 18 Oct 2013 15:16:54 +0000
Subject: [PATCHv3][ 03/11] video: imxfb: Also add pwmr for the device tree.
Message-Id: <1382109422-24454-3-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382109422-24454-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1382109422-24454-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

pwmr has to be set to get the imxfb backlight work,
though pwmr was only configurable trough the platform data.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
 drivers/video/imxfb.c                              |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Docum=
entation/devicetree/bindings/video/fsl,imx-fb.txt
index 46da08d..ac457ae 100644
--- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
@@ -17,6 +17,9 @@ Required nodes:
 Optional properties:
 - fsl,dmacr: DMA Control Register value. This is optional. By default, the
 	register is not modified as recommended by the datasheet.
+- fsl,pwmr:  LCDC PWM Contrast Control Register value. That property is
+	optional, but defining it is necessary to get the backlight working. If t=
hat
+	property is ommited, the register is zeroed.
 - fsl,lscr1: LCDC Sharp Configuration Register value.
=20
 Example:
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 4dd7678..9da29b3 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -833,6 +833,8 @@ static int imxfb_init_fbinfo(struct platform_device *pd=
ev)
=20
 		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
=20
+		of_property_read_u32(np, "fsl,pwmr", &fbi->pwmr);
+
 		/* These two function pointers could be used by some specific
 		 * platforms. */
 		fbi->lcd_power =3D NULL;
--=20
1.7.9.5

