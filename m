From: Michal Simek <michal.simek@xilinx.com>
Date: Fri, 31 May 2013 12:55:31 +0000
Subject: [PATCH v3 1/8] video: xilinxfb: Fix OF probing on little-endian systems
Message-Id: <0a546c3de84c4650d019274debef0ded9007b36f.1370004925.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-8083-1370004950-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1370004925.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-8083-1370004950-0001

From: Michal Simek <monstr@monstr.eu>

DTB is always big-endian that's why it is necessary
to properly convert value (*p).
It is automatically done in of_property_read_u32().

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v3: None
Changes in v2:
- use of_property_read_u32 helper function
Series-changes: 3
- fix commit message

 drivers/video/xilinxfb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index af0b4fd..aecd15d 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -406,8 +406,7 @@ static int xilinxfb_release(struct device *dev)
 static int xilinxfb_of_probe(struct platform_device *op)
 {
 	const u32 *prop;
-	u32 *p;
-	u32 tft_access;
+	u32 tft_access = 0;
 	struct xilinxfb_platform_data pdata;
 	struct resource res;
 	int size, rc;
@@ -427,8 +426,8 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	 * To check whether the core is connected directly to DCR or PLB
 	 * interface and initialize the tft_access accordingly.
 	 */
-	p = (u32 *)of_get_property(op->dev.of_node, "xlnx,dcr-splb-slave-if", NULL);
-	tft_access = p ? *p : 0;
+	of_property_read_u32(op->dev.of_node, "xlnx,dcr-splb-slave-if",
+			     &tft_access);

 	/*
 	 * Fill the resource structure if its direct PLB interface
--
1.8.2.3


--=_mimegpg-monstr-desktop-8083-1370004950-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGondYACgkQykllyylKDCFxWgCglLhiu60BXosY0FrAMT4CWmpt
KqoAoJHGg/t2JL10JyXGVuSd+2MvDYqh
=+Z/a
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-8083-1370004950-0001--
