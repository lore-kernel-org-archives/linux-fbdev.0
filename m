From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 12 Jan 2017 11:16:31 +0000
Subject: [PATCH 5/6] fbdev/ssd1307fb: clear screen in probe
Message-Id: <143ff7d742184fe9bfc968ea8cfee25d23578168.1484219137.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484219137.git.jsarha@ti.com>
In-Reply-To: <cover.1484219137.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

SSD1306 does not clear the panel's framebuffer automatically, even if a
HW reset happens, so we need to do that at probe time before enabling
the panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/ssd1307fb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 616a6a3..5c87ae4 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -441,9 +441,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	/* Clear the screen if we could not give reset at probe time */
-	if (!par->reset)
-		ssd1307fb_update_display(par);
+	/* Clear the screen */
+	ssd1307fb_update_display(par);
 
 	/* Turn on the display */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
-- 
1.9.1

