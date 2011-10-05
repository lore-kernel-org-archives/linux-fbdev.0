From: Axel Lin <axel.lin@gmail.com>
Date: Wed, 05 Oct 2011 08:01:38 +0000
Subject: [PATCH] video: platinumfb: Add __devexit_p at necessary place
Message-Id: <1317801698.12133.1.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

According to the comments in include/linux/init.h:

"Pointers to __devexit functions must use __devexit_p(function_name), the
wrapper will insert either the function_name or NULL, depending on the config
options."

We have __devexit annotation for platinumfb_remove(), thus add __devexit_p at
necessary place.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/platinumfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 6694923..ae3caa6 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -683,7 +683,7 @@ static struct platform_driver platinum_driver  		.of_match_table = platinumfb_match,
 	},
 	.probe		= platinumfb_probe,
-	.remove		= platinumfb_remove,
+	.remove		= __devexit_p(platinumfb_remove),
 };
 
 static int __init platinumfb_init(void)
-- 
1.7.4.1



