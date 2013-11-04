From: Denis Carikli <denis@eukrea.com>
Date: Mon, 04 Nov 2013 16:15:23 +0000
Subject: [PATCHv4][ 5/6] ARM: dts: i.MX35: Add display support.
Message-Id: <1383581724-14817-5-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Splitted the imx35.dtsi display support (new patch).
---
 arch/arm/boot/dts/imx35.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 0f67f22..9a46146 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -349,6 +349,22 @@
 				status =3D "disabled";
 			};
=20
+			ipu: ipu@53fc0000 {
+				compatible =3D "fsl,imx31-ipu";
+				reg =3D <	0x53fc0000 0x5f
+					0x53fc0088 0x2b >;
+				interrupts =3D <42 41>;
+				clocks =3D <&clks 55>;
+				status =3D "disabled";
+			};
+
+			lcdc: mx3fb@53fc00b4 {
+				compatible =3D "fsl,mx3-fb";
+				reg =3D <0x53fc00b4 0x0b>;
+				clocks =3D <&clks 55>;
+				status =3D "disabled";
+			};
+
 			audmux: audmux@53fc4000 {
 				compatible =3D "fsl,imx35-audmux", "fsl,imx31-audmux";
 				reg =3D <0x53fc4000 0x4000>;
--=20
1.7.9.5

