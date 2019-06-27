From: Lukas Schneider <lukas.s.schneider@fau.de>
Date: Thu, 27 Jun 2019 12:12:40 +0000
Subject: [PATCH] fbtft: Cleanup line over 80 character warnings
Message-Id: <20190627121240.31584-1-lukas.s.schneider@fau.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: leobras.c@gmail.com, digholebhagyashri@gmail.com, bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch, der_wolf_@web.de, payal.s.kshirsagar.98@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Lukas Schneider <lukas.s.schneider@fau.de>, Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de

Cleanup the line over 80 character warnings, reported by checkpatch

Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/fbtft/fbtft-sysfs.c |  3 ++-
 drivers/staging/fbtft/fbtft.h       | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 2a5c630dab87..78d2b81ea2e7 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -68,7 +68,8 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 			ret = get_next_ulong(&curve_p, &val, " ", 16);
 			if (ret)
 				goto out;
-			curves[curve_counter * par->gamma.num_values + value_counter] = val;
+			curves[curve_counter * par->gamma.num_values
+				+ value_counter] = val;
 			value_counter++;
 		}
 		if (value_counter != par->gamma.num_values) {
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 9b6bdb62093d..cddbfd4ffa10 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -348,9 +348,25 @@ module_exit(fbtft_driver_module_exit);
 
 /* shorthand debug levels */
 #define DEBUG_LEVEL_1	DEBUG_REQUEST_GPIOS
-#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 | DEBUG_DRIVER_INIT_FUNCTIONS | DEBUG_TIME_FIRST_UPDATE)
-#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 | DEBUG_RESET | DEBUG_INIT_DISPLAY | DEBUG_BLANK | DEBUG_REQUEST_GPIOS | DEBUG_FREE_GPIOS | DEBUG_VERIFY_GPIOS | DEBUG_BACKLIGHT | DEBUG_SYSFS)
-#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 | DEBUG_FB_READ | DEBUG_FB_WRITE | DEBUG_FB_FILLRECT | DEBUG_FB_COPYAREA | DEBUG_FB_IMAGEBLIT | DEBUG_FB_BLANK)
+#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 |		\
+			 DEBUG_DRIVER_INIT_FUNCTIONS |	\
+			 DEBUG_TIME_FIRST_UPDATE)
+#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 |		\
+			 DEBUG_RESET |			\
+			 DEBUG_INIT_DISPLAY |		\
+			 DEBUG_BLANK |			\
+			 DEBUG_REQUEST_GPIOS |		\
+			 DEBUG_FREE_GPIOS |		\
+			 DEBUG_VERIFY_GPIOS |		\
+			 DEBUG_BACKLIGHT |		\
+			 DEBUG_SYSFS)
+#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 |		\
+			 DEBUG_FB_READ |		\
+			 DEBUG_FB_WRITE |		\
+			 DEBUG_FB_FILLRECT |		\
+			 DEBUG_FB_COPYAREA |		\
+			 DEBUG_FB_IMAGEBLIT |		\
+			 DEBUG_FB_BLANK)
 #define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 | DEBUG_UPDATE_DISPLAY)
 #define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
 #define DEBUG_LEVEL_7	0xFFFFFFFF
@@ -392,7 +408,9 @@ module_exit(fbtft_driver_module_exit);
 #define fbtft_init_dbg(dev, format, arg...)                  \
 do {                                                         \
 	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
+		(((struct fbtft_platform_data *)	     \
+		(dev)->platform_data)->display.debug	     \
+		& DEBUG_DRIVER_INIT_FUNCTIONS)))	     \
 		dev_info(dev, format, ##arg);                \
 } while (0)
 
-- 
2.19.1
