From: Michal Simek <michal.simek@xilinx.com>
Date: Mon, 03 Jun 2013 10:13:21 +0000
Subject: [PATCH v4 6/7] video: xilinxfb: Add support for little endian accesses
Message-Id: <818df253e24e333befbbdb35c027a3cece1830a9.1370254386.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-9798-1370254420-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370254386.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1370254386.git.michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@tabi.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-9798-1370254420-0001

Dynamically detect endianess on IP and use
ioread/iowrite functions instead of powerpc and microblaze
specific out_be32.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v4:
- Acked by Arnd

Changes in v3:
- New patch in this patchset based on discussions

Changes in v2: None

 drivers/video/xilinxfb.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index bd3b85d..f3d4a69 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -117,6 +117,7 @@ static struct fb_var_screeninfo xilinx_fb_var = {


 #define BUS_ACCESS_FLAG		0x1 /* 1 = BUS, 0 = DCR */
+#define LITTLE_ENDIAN_ACCESS	0x2 /* LITTLE ENDIAN IO functions */

 struct xilinxfb_drvdata {

@@ -153,14 +154,33 @@ struct xilinxfb_drvdata {
 static void xilinx_fb_out32(struct xilinxfb_drvdata *drvdata, u32 offset,
 				u32 val)
 {
-	if (drvdata->flags & BUS_ACCESS_FLAG)
-		out_be32(drvdata->regs + (offset << 2), val);
+	if (drvdata->flags & BUS_ACCESS_FLAG) {
+		if (drvdata->flags & LITTLE_ENDIAN_ACCESS)
+			iowrite32(val, drvdata->regs + (offset << 2));
+		else
+			iowrite32be(val, drvdata->regs + (offset << 2));
+	}
 #ifdef CONFIG_PPC_DCR
 	else
 		dcr_write(drvdata->dcr_host, offset, val);
 #endif
 }

+static u32 xilinx_fb_in32(struct xilinxfb_drvdata *drvdata, u32 offset)
+{
+	if (drvdata->flags & BUS_ACCESS_FLAG) {
+		if (drvdata->flags & LITTLE_ENDIAN_ACCESS)
+			return ioread32(drvdata->regs + (offset << 2));
+		else
+			return ioread32be(drvdata->regs + (offset << 2));
+	}
+#ifdef CONFIG_PPC_DCR
+	else
+		return dcr_read(drvdata->dcr_host, offset);
+#endif
+	return 0;
+}
+
 static int
 xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
 	unsigned transp, struct fb_info *fbi)
@@ -271,6 +291,12 @@ static int xilinxfb_assign(struct platform_device *pdev,

 	/* Tell the hardware where the frame buffer is */
 	xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
+	rc = xilinx_fb_in32(drvdata, REG_FB_ADDR);
+	/* Endianess detection */
+	if (rc != drvdata->fb_phys) {
+		drvdata->flags |= LITTLE_ENDIAN_ACCESS;
+		xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
+	}

 	/* Turn on the display */
 	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
--
1.8.2.3


--=_mimegpg-monstr-desktop-9798-1370254420-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGsbFQACgkQykllyylKDCF8ewCeLODXNYkSRQThULFJ0zXOP4Re
YEMAn3ZN8ZHZ7SQCADewiGGiZoGTloV/
=aMDV
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-9798-1370254420-0001--
