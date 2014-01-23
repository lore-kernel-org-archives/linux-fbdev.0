From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Jan 2014 19:40:02 +0000
Subject: [PATCH 4/10] atyfb: set FBINFO_READS_FAST
Message-Id: <alpine.LRH.2.02.1401231439310.7971@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+55aFxPfHmpcMH-bmRcTPUQeq5=67cKVmra6+SvT26ybvQaug@mail.gmail.com>
In-Reply-To: <CA+55aFxPfHmpcMH-bmRcTPUQeq5=67cKVmra6+SvT26ybvQaug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Set FBINFO_READS_FAST so that the console code uses scrolling instead of
rewriting. This improves scrolling speed.

A time to do ls -la /usr/bin:
	original patched
32bpp	4.9	3.6
24bpp	4.9	2.9
16bpp	4.9	2.1
8bpp	4.9	1.7

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/aty/atyfb_base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-3.13-rc1/drivers/video/aty/atyfb_base.c
=================================--- linux-3.13-rc1.orig/drivers/video/aty/atyfb_base.c	2013-11-27 00:25:42.000000000 +0100
+++ linux-3.13-rc1/drivers/video/aty/atyfb_base.c	2013-11-27 00:25:55.000000000 +0100
@@ -2653,7 +2653,8 @@ static int aty_init(struct fb_info *info
 		      FBINFO_HWACCEL_IMAGEBLIT |
 		      FBINFO_HWACCEL_FILLRECT  |
 		      FBINFO_HWACCEL_COPYAREA  |
-		      FBINFO_HWACCEL_YPAN;
+		      FBINFO_HWACCEL_YPAN      |
+		      FBINFO_READS_FAST;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && of_machine_is_compatible("PowerBook1,1")) {

