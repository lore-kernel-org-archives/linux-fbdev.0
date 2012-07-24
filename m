From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Jul 2012 08:19:13 +0000
Subject: [PATCH] fbdev: Make pixel_to_pat() failure mode more friendly
Message-Id: <1343117953.3715.23.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If we accidentally pass an incorrect bpp value to pixel_to_pat(),
it panics. This is pretty useless, as we generally have the various
console locks held at that point, so nothing will be displayed,
and there is no reason to make this a fatal event.

Let's WARN instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/video/fb_draw.h b/drivers/video/fb_draw.h
index 04c01fa..624ee11 100644
--- a/drivers/video/fb_draw.h
+++ b/drivers/video/fb_draw.h
@@ -3,6 +3,7 @@
 
 #include <asm/types.h>
 #include <linux/fb.h>
+#include <linux/bug.h>
 
     /*
      *  Compose two values, using a bitmask as decision value
@@ -41,7 +42,8 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 32:
 		return 0x0000000100000001ul*pixel;
 	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
+		WARN(1, "pixel_to_pat(): unsupported pixelformat %d\n", bpp);
+		return 0;
     }
 }
 #else
@@ -66,7 +68,8 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 32:
 		return 0x00000001ul*pixel;
 	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
+		WARN(1, "pixel_to_pat(): unsupported pixelformat %d\n", bpp);
+		return 0;
     }
 }
 #endif


