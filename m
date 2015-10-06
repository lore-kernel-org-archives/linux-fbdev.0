From: Lars Svensson <lars1.svensson@sonymobile.com>
Date: Tue, 06 Oct 2015 07:02:05 +0000
Subject: [PATCH 1/2] fb.h: Provide alternate screen_base pointer
Message-Id: <1444114926-18000-1-git-send-email-lars1.svensson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, Lars Svensson <lars1.svensson@sonymobile.com>

Some drivers use member screen_base of struct fb_info to store non-
__iomem pointers, creating the need for ugly __force typecasts to
avoid sparse warnings. This adds an alternate pointer without the
__iomem qualifyer for this use.

Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>
---
New version of my previous patch, reworked as suggested by Dan
Carpenter. For the name of the pointer, "screen_buffer" was the
best I could come up with. Other suggestions?

//Lars
---
 include/linux/fb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index bc9afa7..41a3b11 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -483,7 +483,10 @@ struct fb_info {
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif
-	char __iomem *screen_base;	/* Virtual address */
+	union {
+		char __iomem *screen_base;	/* Virtual address */
+		char *screen_buffer;
+	};
 	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */ 
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0
-- 
2.4.2

