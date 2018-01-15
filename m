From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 15 Jan 2018 16:59:46 +0000
Subject: [PATCH 1/2] video: udlfb: Constify read only data
Message-Id: <20180115165946.GA20134@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Both dlfb_fix and fb_device_attrs are never written to, so
it is safe to make them const.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 47e31668f316..f0118c10b4ab 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -32,7 +32,7 @@
 #include <video/udlfb.h>
 #include "edid.h"
 
-static struct fb_fix_screeninfo dlfb_fix = {
+static const struct fb_fix_screeninfo dlfb_fix = {
 	.id =           "udlfb",
 	.type =         FB_TYPE_PACKED_PIXELS,
 	.visual =       FB_VISUAL_TRUECOLOR,
@@ -1455,7 +1455,7 @@ static const struct bin_attribute edid_attr = {
 	.write = edid_store
 };
 
-static struct device_attribute fb_device_attrs[] = {
+static const struct device_attribute fb_device_attrs[] = {
 	__ATTR_RO(metrics_bytes_rendered),
 	__ATTR_RO(metrics_bytes_identical),
 	__ATTR_RO(metrics_bytes_sent),
-- 
2.15.1

