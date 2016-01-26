From: Stefan Agner <stefan@agner.ch>
Date: Tue, 26 Jan 2016 01:29:16 +0000
Subject: [PATCH] video: fbdev: mxsfb: fix pixelclock polarity
Message-Id: <1453771756-5418-1-git-send-email-stefan@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, shawnguo@kernel.org
Cc: s.hauer@pengutronix.de, Ying.Liu@freescale.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, LW@KARO-electronics.de, fabio.estevam@freescale.com, max.krummenacher@toradex.com, Stefan Agner <stefan@agner.ch>

The PIXDATA flags of the display_flags enum are controller centric,
e.g. NEGEDGE means the controller shall drive the data signals on
pixelclocks negative edge. However, the drivers flag is display
centric: Sample the data on negative (falling) edge.

Therefore, change the if statement to check for the POSEDGE flag
(which is typically not set):
Drive on positive edge => sample on negative edge

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi all

Shawn, I would like to have at least your Ack on this before merge.

It seems that this has been wrong since the driver is able to use
the timings from the device tree, introduced with 669406534b4a
("video: mxsfb: get display timings from device tree").

Not sure how many device trees actually specify the wrong pixel clock
polarity due to that. At least the initial flag convertion from the
old platform data structures done with 0d9f8217db15 ("ARM: mxs: move
display timing configurations into device tree") seems to be affected
and would need to be changed accordingly...

Not sure how we should handle this, maybe just invert all
pixelclk-active properties where the mxsfb driver is in use...?

--
Stefan

 drivers/video/fbdev/mxsfb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 4e6608c..38898a9 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -150,7 +150,7 @@
 #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
 
 #define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negtive edge sampling */
+#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative edge sampling */
 
 enum mxsfb_devtype {
 	MXSFB_V3,
@@ -788,7 +788,16 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
 
 	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
 		host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
-	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+
+	/*
+	 * The PIXDATA flags of the display_flags enum are controller
+	 * centric, e.g. NEGEDGE means drive data on negative edge.
+	 * However, the drivers flag is display centric: Sample the
+	 * data on negative (falling) edge. Therefore, check for the
+	 * POSEDGE flag:
+	 * drive on positive edge => sample on negative edge
+	 */
+	if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
 		host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
 
 put_display_node:
-- 
2.7.0

