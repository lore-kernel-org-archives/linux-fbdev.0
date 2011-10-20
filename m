From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Oct 2011 11:42:24 +0000
Subject: [PATCH 3/4] fbdev/cirrusfb: Add support for Picasso IV in Zorro II mode
Message-Id: <1319110945-25684-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1319110945-25684-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1319110945-25684-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Ingo=20J=C3=BCrgensmann?= <ij@2011.bluespice.org>, Geert Uytterhoeven <geert@linux-m68k.org>

In Zorro II mode, the Village Tronic Picasso IV graphics card shows up as
either 2 or 3 Zorro devices:
  - One for the registers of the Cirrus Logic graphics chip,
  - One for the first bank of 2 MiB of graphics memory,
  - An optional one for the second bank of 2 MiB of graphics memory,
    if there was enough free Zorro II address space.

Based on src/sys/arch/amiga/dev/grf_cl.c from NetBSD.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
--
Untested, due to lack of hardware
---
 drivers/video/cirrusfb.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 357139a..816433f 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -287,6 +287,7 @@ struct zorrocl {
 				/* If zero, use autoprobe on RAM device */
 	u32 ramoffset;		/* Offset of video RAM in first Zorro device */
 	zorro_id ramid;		/* Zorro ID of RAM device */
+	zorro_id ramid2;	/* Zorro ID of optional second RAM device */
 };
 
 static const struct zorrocl zcl_sd64 __devinitconst = {
@@ -316,6 +317,13 @@ static const struct zorrocl zcl_picasso4_z3 __devinitconst = {
 	.ramoffset	= 0x01000000,
 };
 
+static const struct zorrocl zcl_picasso4_z2 __devinitconst = {
+	.type		= BT_PICASSO4,
+	.regoffset	= 0x10000,
+	.ramid		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM1,
+	.ramid2		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM2,
+};
+
 
 static const struct zorro_device_id cirrusfb_zorro_table[] __devinitconst = {
 	{
@@ -333,6 +341,9 @@ static const struct zorro_device_id cirrusfb_zorro_table[] __devinitconst = {
 	}, {
 		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
 		.driver_data	= (unsigned long)&zcl_picasso4_z3,
+	}, {
+		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG,
+		.driver_data	= (unsigned long)&zcl_picasso4_z2,
 	},
 	{ 0 }
 };
@@ -2257,6 +2268,16 @@ static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
 		}
 		rambase = zorro_resource_start(ram);
 		ramsize = zorro_resource_len(ram);
+		if (zcl->ramid2 &&
+		    (ram = zorro_find_device(zcl->ramid2, NULL))) {
+			if (zorro_resource_start(ram) != rambase + ramsize) {
+				dev_warn(info->device,
+					 "Skipping non-contiguous RAM at %pR\n",
+					 &ram->resource);
+			} else {
+				ramsize += zorro_resource_len(ram);
+			}
+		}
 	}
 
 	dev_info(info->device,
-- 
1.7.0.4

