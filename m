From: Tormod Volden <lists.tormod@gmail.com>
Date: Sun, 10 Apr 2011 20:57:34 +0000
Subject: [PATCH 1/2] savagefb: New S3_TWISTER and S3_PROSAVAGEDDR chip families
Message-Id: <1302469055-3400-1-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

Realign the chip families with the Xorg DDX

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

This commit should functionally be a NOP, only prepares for the next patch.

Regards,
Tormod

 drivers/video/savage/savagefb-i2c.c    |    2 ++
 drivers/video/savage/savagefb.h        |    8 +++++---
 drivers/video/savage/savagefb_driver.c |   12 ++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index bb71fea..80fa87e 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -171,6 +171,8 @@ void savagefb_create_i2c_busses(struct fb_info *info)
 
 	switch (par->chip) {
 	case S3_PROSAVAGE:
+	case S3_PROSAVAGEDDR:
+	case S3_TWISTER:
 		par->chan.reg         = CR_SERIAL2;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = prosavage_gpio_setsda;
diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
index e4c3f21..6f20ae4 100644
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -36,7 +36,6 @@
 #define PCI_CHIP_SAVAGE_IX    0x8c13
 #define PCI_CHIP_PROSAVAGE_PM 0x8a25
 #define PCI_CHIP_PROSAVAGE_KM 0x8a26
- /* Twister is a code name; hope I get the real name soon. */
 #define PCI_CHIP_S3TWISTER_P  0x8d01
 #define PCI_CHIP_S3TWISTER_K  0x8d02
 #define PCI_CHIP_PROSAVAGE_DDR          0x8d03
@@ -52,14 +51,15 @@
 #define PCI_CHIP_SUPSAV_IXCDDR		0x8c2f
 
 
+#define S3_SAVAGE_SERIES(chip)    ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE2000))
 
 #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE_MX))
 
-#define S3_SAVAGE4_SERIES(chip)   ((chip=S3_SAVAGE4) || (chip=S3_PROSAVAGE))
+#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) || (chip<=S3_PROSAVAGEDDR))
 
 #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip=S3_SAVAGE_MX) || (chip=S3_SUPERSAVAGE))
 
-#define S3_SAVAGE_SERIES(chip)    ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE2000))
+#define S3_MOBILE_TWISTER_SERIES(chip) ((chip=S3_TWISTER) || (chip=S3_PROSAVAGEDDR))
 
 /* Chip tags.  These are used to group the adapters into
  * related families.
@@ -71,6 +71,8 @@ typedef enum {
   S3_SAVAGE_MX,
   S3_SAVAGE4,
   S3_PROSAVAGE,
+  S3_TWISTER,
+  S3_PROSAVAGEDDR,
   S3_SUPERSAVAGE,
   S3_SAVAGE2000,
   S3_LAST
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 487911e..0be3f31 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -328,7 +328,9 @@ SavageSetup2DEngine(struct savagefb_par  *par)
 		savage_out32(0x48C18, savage_in32(0x48C18, par) | 0x0C, par);
 		break;
 	case S3_SAVAGE4:
+	case S3_TWISTER:
 	case S3_PROSAVAGE:
+	case S3_PROSAVAGEDDR:
 	case S3_SUPERSAVAGE:
 		/* Disable BCI */
 		savage_out32(0x48C18, savage_in32(0x48C18, par) & 0x3FF0, par);
@@ -1886,6 +1888,8 @@ static int savage_init_hw(struct savagefb_par *par)
 		break;
 
 	case S3_PROSAVAGE:
+	case S3_PROSAVAGEDDR:
+	case S3_TWISTER:
 		videoRam = RamSavageNB[(config1 & 0xE0) >> 5] * 1024;
 		break;
 
@@ -2111,19 +2115,19 @@ static int __devinit savage_init_fb_info(struct fb_info *info,
 		snprintf(info->fix.id, 16, "ProSavageKM");
 		break;
 	case FB_ACCEL_S3TWISTER_P:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_TWISTER;
 		snprintf(info->fix.id, 16, "TwisterP");
 		break;
 	case FB_ACCEL_S3TWISTER_K:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_TWISTER;
 		snprintf(info->fix.id, 16, "TwisterK");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDR:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_PROSAVAGEDDR;
 		snprintf(info->fix.id, 16, "ProSavageDDR");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDRK:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_PROSAVAGEDDR;
 		snprintf(info->fix.id, 16, "ProSavage8");
 		break;
 	}
-- 
1.7.0.4

