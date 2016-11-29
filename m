From: Martin Kaiser <martin@kaiser.cx>
Date: Tue, 29 Nov 2016 19:50:39 +0000
Subject: [PATCH v2] video: imxfb: remove the macros for initializing the DMACR
Message-Id: <1480449039-14774-1-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161129074949.taj5bwnhge37pi5e@pengutronix.de>
In-Reply-To: <20161129074949.taj5bwnhge37pi5e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>

The current definitions of DMACR_HM() and DMACR_TM() are correct only
for imx1, they're wrong for imx21.

The macros are meant for legacy board files only, they're not applicable
for boards using device tree.

At the moment, there are no boards using these macros. So it should be
safe to drop them rather than making them work for both imx1 and imx21,
which would require a change in the platform data struct.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Change in v2:
    fixed the commit message

 include/linux/platform_data/video-imxfb.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index 18e9083..a5c0a71 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -47,10 +47,6 @@
 #define LSCR1_GRAY2(x)            (((x) & 0xf) << 4)
 #define LSCR1_GRAY1(x)            (((x) & 0xf))
 
-#define DMACR_BURST	(1 << 31)
-#define DMACR_HM(x)	(((x) & 0xf) << 16)
-#define DMACR_TM(x)	((x) & 0xf)
-
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
-- 
1.7.10.4

