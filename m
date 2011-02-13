From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 13 Feb 2011 04:02:10 +0000
Subject: [PATCH] video: metronomefb: add __devexit_p around reference to
Message-Id: <1297569730.3608.3.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

metronomefb_remove is marked __devexit,
thus add __devexit_p around reference to metronomefb_remove.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/metronomefb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 63ed3b7..ed64edf 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -765,7 +765,7 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
 
 static struct platform_driver metronomefb_driver = {
 	.probe	= metronomefb_probe,
-	.remove = metronomefb_remove,
+	.remove = __devexit_p(metronomefb_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "metronomefb",
-- 
1.7.1



