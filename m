From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 29 May 2013 16:12:56 +0000
Subject: [PATCH 1/3] video: xilinxfb: Fix OF probing on little-endian systems
Message-Id: <502367ddf6d79b7b343b3165ad54cb9e2d4713db.1369843969.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-20177-1369843978-0001"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@xilinx.com>, Pallav Joshi <pallav.joshi@xilinx.com>, git-dev@xilinx.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-20177-1369843978-0001

From: Michal Simek <monstr@monstr.eu>

DTB is always big-endian that's why is necessary
to convert it.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/video/xilinxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index af0b4fd..5af341e 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -428,7 +428,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	 * interface and initialize the tft_access accordingly.
 	 */
 	p = (u32 *)of_get_property(op->dev.of_node, "xlnx,dcr-splb-slave-if", NULL);
-	tft_access = p ? *p : 0;
+	tft_access = p ? be32_to_cpup(p) : 0;

 	/*
 	 * Fill the resource structure if its direct PLB interface
--
1.8.2.3


--=_mimegpg-monstr-desktop-20177-1369843978-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGmKQoACgkQykllyylKDCGRDACdFhAfvGOqg5FRNxxY7Z6jpDjT
UJkAn0qNz0kIgKdx64JbuIlvuKX9fooG
=azUL
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-20177-1369843978-0001--
