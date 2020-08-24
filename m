From: Timo Aranjo <timo.aranjo@aol.com>
Date: Mon, 24 Aug 2020 23:02:26 +0000
Subject: [PATCH] Staging: sm750fb: Fixed a coding style issue
Message-Id: <1b596369-7c83-73ff-fd4e-ed0d7a714219@aol.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

 From 56c5eed5b0a3d299530264509a6a81594c4fb791 Mon Sep 17 00:00:00 2001
From: "Timo A. Aranjo" <timo.aranjo@aol.com>
Date: Mon, 24 Aug 2020 17:24:16 -0500
Subject: [PATCH] Staging: sm750fb: Fixed a coding style issue

I added a new-line because checkpatch gave a warning about there not being
a new line after declarations.

Signed-off-by: Timo Alejandro Aranjo <timo.aranjo@aol.com>
---
  drivers/staging/sm750fb/sm750.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c 
b/drivers/staging/sm750fb/sm750.c
index 84fb585a5739..3da87387867e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -411,6 +411,7 @@ static int __maybe_unused lynxfb_suspend(struct 
device *dev)
  {
  	struct fb_info *info;
  	struct sm750_dev *sm750_dev;
+
  	sm750_dev = dev_get_drvdata(dev);

  	console_lock();
-- 
2.25.1
