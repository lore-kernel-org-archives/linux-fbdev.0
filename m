From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2011 20:53:53 +0000
Subject: [PATCH 2/8] fbdev/amifb: Fix double free
Message-Id: <1321908839-11419-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 72454c7..39d211a 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2464,7 +2464,6 @@ static void amifb_deinit(struct platform_device *pdev)
 {
 	if (fb_info.cmap.len)
 		fb_dealloc_cmap(&fb_info.cmap);
-	fb_dealloc_cmap(&fb_info.cmap);
 	chipfree();
 	if (videomemory)
 		iounmap((void *)videomemory);
-- 
1.7.0.4

