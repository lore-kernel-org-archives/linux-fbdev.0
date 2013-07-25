From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 25 Jul 2013 13:45:26 +0000
Subject: [PATCH v3] video: xilinxfb: Fix compilation warning
Message-Id: <b8701d73538d37495b41ef465440a6d5f3018870.1374759923.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-15536-1374759927-0001"
List-Id: <linux-fbdev.vger.kernel.org>
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-15536-1374759927-0001

regs_phys is phys_addr_t (u32 or u64).
Lets use %pa printk format specifier.

Fixes compilation warning introduced by:
video: xilinxfb: Use drvdata->regs_phys instead of physaddr
(sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v3:
- Fix commit message reported by Geert

Changes in v2:
- Use %pa instead of casting

ppc44x_defconfig
Fixes regressions in v3.11-rc2

---
 drivers/video/xilinxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index f3d4a69..6629b29 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -341,8 +341,8 @@ static int xilinxfb_assign(struct platform_device *pdev,

 	if (drvdata->flags & BUS_ACCESS_FLAG) {
 		/* Put a banner in the log (for DEBUG) */
-		dev_dbg(dev, "regs: phys=%x, virt=%p\n", drvdata->regs_phys,
-					drvdata->regs);
+		dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
+			&drvdata->regs_phys, drvdata->regs);
 	}
 	/* Put a banner in the log (for DEBUG) */
 	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
--
1.8.2.3


--=_mimegpg-monstr-desktop-15536-1374759927-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHxK/cACgkQykllyylKDCG6UgCgmCCmUqtQEUu5SUJ+MDQfWVTa
ZMoAnjvQS4QFdVcgANKYD0PSJx9+bnEg
=w7dv
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-15536-1374759927-0001--
