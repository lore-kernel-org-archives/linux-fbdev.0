From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 08 Aug 2017 22:17:30 +0000
Subject: [PATCH] video: fbdev: pxa3xx_gcu: fix error return code in pxa3xx_gcu_probe()
Message-Id: <20170808221729.GA2208@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

platform_get_irq() returns an error code, but the pxa3xx_gcu driver
ignores it and always returns -ENODEV. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Also, notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=E330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-=
gcu.c
index 50bce45..933619d 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -626,8 +626,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pde=
v)
 	/* request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no IRQ defined\n");
-		return -ENODEV;
+		dev_err(dev, "no IRQ defined: %d\n", irq);
+		return irq;
 	}
=20
 	ret =3D devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
--=20
2.5.0

