From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 04 Nov 2017 21:24:20 +0000
Subject: [PATCH 2/3] sm501fb: unregister framebuffer only if registered
Message-Id: <1509830661-7384-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

There are cases when panel and crt both are not defined and only one of
them is defined and initialized. In such cases, while removing the
device, unregister the framebuffer only if it was registered.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/video/fbdev/sm501fb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 381475f..577a483 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2079,8 +2079,10 @@ static int sm501fb_remove(struct platform_device *pdev)
 	sm501_free_init_fb(info, HEAD_CRT);
 	sm501_free_init_fb(info, HEAD_PANEL);
 
-	unregister_framebuffer(fbinfo_crt);
-	unregister_framebuffer(fbinfo_pnl);
+	if (fbinfo_crt)
+		unregister_framebuffer(fbinfo_crt);
+	if (fbinfo_pnl)
+		unregister_framebuffer(fbinfo_pnl);
 
 	sm501fb_stop(info);
 	kfree(info);
-- 
2.1.4

