From: Joe Perches <joe@perches.com>
Subject: [PATCH 50/62] drivers/video/imxfb.c: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:26:55 -0700
Message-ID: <b3809f274f910612520e30bc4a53d4fcb905771c.1246173683.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759686AbZF1Qil@vger.kernel.org>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sascha Hauer <kernel@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/imxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 15a0ee6..89e6f1e 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -677,7 +677,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 
 	fbi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(fbi->clk)) {
-		ret = PTR_ERR(fbi->clk);;
+		ret = PTR_ERR(fbi->clk);
 		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
 		goto failed_getclock;
 	}
-- 
1.6.3.1.10.g659a0.dirty
