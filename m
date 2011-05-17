From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 May 2011 09:45:38 +0000
Subject: [PATCH] video: s3c2410fb: use resource_size()
Message-Id: <1305625538-32302-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch uses the resource_size help function instead of
manually calculating the resource size. It can reduce the chance
of introducing off-by-one errors.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c2410fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 61c819e..4226ec3 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -867,7 +867,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
 		goto dealloc_fb;
 	}
 
-	size = (res->end - res->start) + 1;
+	size = resource_size(res);
 	info->mem = request_mem_region(res->start, size, pdev->name);
 	if (info->mem = NULL) {
 		dev_err(&pdev->dev, "failed to get memory region\n");
-- 
1.7.1

