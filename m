From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:27:58 +0000
Subject: [PATCHv2 05/10] fbdev: ssd1307fb: fix in tree users of ssd1306
Message-Id: <1425248883-25367-6-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

introducing the new DT properties the in tree users of the SSD1306
controller are updated to be up to date.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28=
-cfa10036.dts
index b04b6b8..faeaa2e 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -99,6 +99,10 @@
 					solomon,height =3D <32>;
 					solomon,width =3D <128>;
 					solomon,page-offset =3D <0>;
+					solomon,segment-remap;
+					solomon,com-lrremap;
+					solomon,com-invdir;
+					solomon,com-offset =3D <32>;
 				};
 			};
=20
--=20
2.3.0

