From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 24 Jul 2013 05:31:40 +0000
Subject: [PATCH] video: xilinxfb: Fix compilation warning
Message-Id: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-13551-1374643900-0001"
List-Id: <linux-fbdev.vger.kernel.org>
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Michal Simek <monstr@monstr.eu>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-13551-1374643900-0001

regs_phys is phys_addr_t (u32 or u64).
Lets retype it to u64.

Fixes compilation warning introduced by:
video: xilinxfb: Use drvdata->regs_phys instead of physaddr
(sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
ppc44x_defconfig
Fixes regressions in v3.11-rc2

---
 drivers/video/xilinxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index f3d4a69..79175a6 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -341,8 +341,8 @@ static int xilinxfb_assign(struct platform_device *pdev,

 	if (drvdata->flags & BUS_ACCESS_FLAG) {
 		/* Put a banner in the log (for DEBUG) */
-		dev_dbg(dev, "regs: phys=%x, virt=%p\n", drvdata->regs_phys,
-					drvdata->regs);
+		dev_dbg(dev, "regs: phys=%llx, virt=%p\n",
+			(unsigned long long)drvdata->regs_phys, drvdata->regs);
 	}
 	/* Put a banner in the log (for DEBUG) */
 	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
--
1.8.2.3


--=_mimegpg-monstr-desktop-13551-1374643900-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHvZrwACgkQykllyylKDCFPjQCgjJoJF7GFcUPw5r0QC1hnK126
JYsAn0uXlDHRPDKyv3t9X5WeICHkXgGg
=cQBD
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-13551-1374643900-0001--
