From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Date: Tue, 28 Aug 2012 04:38:03 +0000
Subject: [PATCH] drivrs/video/jz4740_fb.c: Use SIMPLE_DEV_PM_OPS instead of dev_pm_ops
Message-Id: <1346128683-21487-1-git-send-email-marcos.souza.org@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Just a cleanup, not functional changes.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

 Just compile test. Please double check.

 drivers/video/jz4740_fb.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index de36693..a53fb7d 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -807,12 +807,7 @@ static int jzfb_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops jzfb_pm_ops = {
-	.suspend	= jzfb_suspend,
-	.resume		= jzfb_resume,
-	.poweroff	= jzfb_suspend,
-	.restore	= jzfb_resume,
-};
+static SIMPLE_DEV_PM_OPS(jzfb_pm_ops, jzfb_suspend, jzfb_resume);
 
 #define JZFB_PM_OPS (&jzfb_pm_ops)
 
-- 
1.7.9.5

