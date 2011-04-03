From: Tormod Volden <lists.tormod@gmail.com>
Date: Sun, 03 Apr 2011 12:54:05 +0000
Subject: [PATCH 2/2] savagefb: Set up I2C based on chip family instead of card id
Message-Id: <1301835246-6520-2-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

In practice this means enabling I2C (for DDC2) on all prosavage cards,
like the xorg ddx does. The savage4 and savage2000 families have only
one member each, so there is no change for those.

Tested on TwisterK.

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

Since this seems to work fine in xorg, I do not expect any surprises.
However, the framebuffer might now come up in higher resolution
and refresh rate (as allowed by the EDID) than the old defaults.
This might uncover broken EDIDs or other mode bugs.

WRT my own testing, I can see that the EDID is read out successfully,
but the external monitor goes black and complains with the chosen mode.
(For the record, the same happened with the non-edid default mode.)
This is because of other bugs in the mode calculations or the
monitor itself I am testing on. With xorg the monitor comes up,
because xorg picks a lower refresh rate by default.

Tormod

 drivers/video/savage/savagefb-i2c.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index 58c8a3c..5e7acda 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -170,9 +170,8 @@ void savagefb_create_i2c_busses(struct fb_info *info)
 	struct savagefb_par *par = info->par;
 	par->chan.par	= par;
 
-	switch(info->fix.accel) {
-	case FB_ACCEL_PROSAVAGE_DDRK:
-	case FB_ACCEL_PROSAVAGE_PM:
+	switch (par->chip) {
+	case S3_PROSAVAGE:
 		par->chan.reg         = CR_SERIAL2;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = prosavage_gpio_setsda;
@@ -180,7 +179,7 @@ void savagefb_create_i2c_busses(struct fb_info *info)
 		par->chan.algo.getsda = prosavage_gpio_getsda;
 		par->chan.algo.getscl = prosavage_gpio_getscl;
 		break;
-	case FB_ACCEL_SAVAGE4:
+	case S3_SAVAGE4:
 		par->chan.reg = CR_SERIAL1;
 		if (par->pcidev->revision > 1 && !(VGArCR(0xa6, par) & 0x40))
 			par->chan.reg = CR_SERIAL2;
@@ -190,7 +189,7 @@ void savagefb_create_i2c_busses(struct fb_info *info)
 		par->chan.algo.getsda = prosavage_gpio_getsda;
 		par->chan.algo.getscl = prosavage_gpio_getscl;
 		break;
-	case FB_ACCEL_SAVAGE2000:
+	case S3_SAVAGE2000:
 		par->chan.reg         = MM_SERIAL1;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = savage4_gpio_setsda;
-- 
1.7.0.4

