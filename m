From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:08 +0000
Subject: [PATCH 15/21] udlfb: set optimal write delay
Message-Id: <20180603144224.393326799@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The default delay 5 jiffies is too much when the kernel is compiled with
HZ0 - it results in jumpy cursor in Xwindow.

In order to find out the optimal delay, I benchmarked the driver on
1280x720x30fps video. I found out that with HZ00, 10ms is acceptable,
but with HZ%0 or HZ00, we need 4ms, so that the video is played
without any frame skips.

This patch changes the delay to this value.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 include/video/udlfb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-4.17-rc7/include/video/udlfb.h
=================================--- linux-4.17-rc7.orig/include/video/udlfb.h	2018-06-03 13:17:37.000000000 +0200
+++ linux-4.17-rc7/include/video/udlfb.h	2018-06-03 13:17:37.000000000 +0200
@@ -88,7 +88,7 @@ struct dlfb_data {
 #define MIN_RAW_PIX_BYTES	2
 #define MIN_RAW_CMD_BYTES	(RAW_HEADER_BYTES + MIN_RAW_PIX_BYTES)
 
-#define DL_DEFIO_WRITE_DELAY    5 /* fb_deferred_io.delay in jiffies */
+#define DL_DEFIO_WRITE_DELAY    msecs_to_jiffies(HZ <= 300 ? 4 : 10) /* optimal value for 720p video */
 #define DL_DEFIO_WRITE_DISABLE  (HZ*60) /* "disable" with long delay */
 
 /* remove these once align.h patch is taken into kernel */

