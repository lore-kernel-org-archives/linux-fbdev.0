From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 17:57:57 +0000
Subject: [PATCH] video: fbdev: omap: omapfb_main.c:  Cleaning up removal variable thet is never used
Message-Id: <1404669477-15842-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404566552-23096-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404566552-23096-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Removal of union member variable thet is never used

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap/omapfb_main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index d8d028d..557aaa3 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1096,7 +1096,6 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 		enum omapfb_update_mode		update_mode;
 		struct omapfb_caps		caps;
 		unsigned int		mirror;
-		int			plane_out;
 		int			enable_plane;
 	} p;
 	int r = 0;
-- 
1.7.10.4

