From: Andrew Kephart <andrew.kephart@alereon.com>
Date: Mon, 13 Dec 2010 15:46:34 +0000
Subject: Re: [PATCH] fbdev: Fix fb_find_nearest_mode refresh comparison
Message-Id: <1292255194.12119.1.camel@kephart>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292019888.2896.17.camel@kephart>
In-Reply-To: <1292019888.2896.17.camel@kephart>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Refresh rate nearness is not calculated or reset when nearest resolution
changes.

This patch resets the refresh rate differential measurement whenever a
new nearest resolution is discovered.  This fixes two error cases;
first, wherein the first mode's refresh rate differential is never
calculated and second, when the closest refresh rate from a previous
nearest resolution is erroneously preserved.

Signed-off-by: Andrew Kephart <andrew.kephart@alereon.com>
---

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c 
index c3a1825..7a61ba6 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -902,6 +902,7 @@ const struct fb_videomode
*fb_find_nearest_mode(const struct fb_videomode *mode,
                        abs(cmode->yres - mode->yres);
                if (diff > d) {
                        diff = d;
+                       diff_refresh = abs(cmode->refresh -
mode->refresh);
                        best = cmode;
                } else if (diff = d) {
                        d = abs(cmode->refresh - mode->refresh);

