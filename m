From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:38:45 +0000
Subject: [PATCH 02/13] FB: sa1100: add .owner initializer to driver structure
Message-Id: <E1Rtc4z-0000aI-HR@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Annotate the driver structure with the .owner field, to allow the
module to be associated with the driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 2cc268c..bac9d4f 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1505,6 +1505,7 @@ static struct platform_driver sa1100fb_driver = {
 	.resume		= sa1100fb_resume,
 	.driver		= {
 		.name	= "sa11x0-fb",
+		.owner	= THIS_MODULE,
 	},
 };
 
-- 
1.7.4.4

