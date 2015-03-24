From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 24 Mar 2015 21:23:50 +0000
Subject: [PATCHv5 03/11] of: Add Solomon Systech vendor prefix.
Message-Id: <1427232238-21099-4-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds the solomon prefix for Solomon Systech Limited.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docume=
ntation/devicetree/bindings/vendor-prefixes.txt
index d3f4809..933c8f5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -169,6 +169,7 @@ sitronix	Sitronix Technology Corporation
 smsc	Standard Microsystems Corporation
 snps	Synopsys, Inc.
 solidrun	SolidRun
+solomon        Solomon Systech Limited
 sony	Sony Corporation
 spansion	Spansion Inc.
 sprd	Spreadtrum Communications Inc.
--=20
2.3.0

