From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 13 Feb 2011 13:06:23 +0000
Subject: [PATCH] video: hecubafb: add __devexit_p around reference to
Message-Id: <1297602383.2433.1.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

hecubafb_remove is marked __devexit,
thus add __devexit_p around reference to hecubafb_remove.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/hecubafb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index c77bcc6..1b94643 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -299,7 +299,7 @@ static int __devexit hecubafb_remove(struct platform_device *dev)
 
 static struct platform_driver hecubafb_driver = {
 	.probe	= hecubafb_probe,
-	.remove = hecubafb_remove,
+	.remove = __devexit_p(hecubafb_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "hecubafb",
-- 
1.7.1



