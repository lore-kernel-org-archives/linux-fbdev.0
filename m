From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Date: Sun, 12 Jun 2011 08:45:01 +0000
Subject: [PATCH] efifb: Fix call to wrong unregister function
Message-Id: <1307868301-1773-1-git-send-email-m.b.lankhorst@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten Lankhorst <m.b.lankhorst@gmail.com>

Seems like driver_unregister must be called instead of device_unregister.

Signed-off-by: Maarten Lankhorst <m.b.lankhorst@gmail.com>
---
 drivers/video/efifb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 69c49df..d8717a6 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -541,7 +541,7 @@ static int __init efifb_init(void)
 	 */
 	ret = platform_driver_probe(&efifb_driver, efifb_probe);
 	if (ret) {
-		platform_device_unregister(&efifb_driver);
+		platform_driver_unregister(&efifb_driver);
 		return ret;
 	}
 
-- 
1.7.4.1

