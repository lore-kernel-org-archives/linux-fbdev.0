From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:20 +0000
Subject: [PATCH 6/9] s3c2410fb: Enable display by default
Message-Id: <1367006543-5458-7-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable the display with default configuration at system start up.
This ensures the display is activated also when FRAMBUFFER_CONSOLE
is not set.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 drivers/video/s3c2410fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 479ab45..da8b6c2 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -969,6 +969,8 @@ static int s3c2410fb_probe(struct platform_device *pdev)
 		goto free_video_memory;
 	}
 
+	s3c2410fb_set_par(fbinfo);
+
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register framebuffer device: %d\n",
-- 
1.7.4.1

