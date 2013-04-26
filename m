From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:22 +0000
Subject: [PATCH 8/9] s3c2410fb: Remove redundant platform_set_drvdata()
Message-Id: <1367006543-5458-9-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

driver_data field is being cleared by the driver core since
commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
device-core: Ensure drvdata = NULL when no driver is bound
hence there is no need to do it in the driver's remove() callback.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 drivers/video/s3c2410fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 11f98ca..0439ed0 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -1013,7 +1013,6 @@ static int s3c2410fb_remove(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	free_irq(irq, info);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	return 0;
-- 
1.7.4.1

