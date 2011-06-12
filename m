From: "wanlong.gao" <wanlong.gao@gmail.com>
Date: Sun, 12 Jun 2011 10:52:33 +0000
Subject: re:[PATCH] efifb: Fix call to wrong unregister function
Message-Id: <1307875953.1859.6.camel@Tux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307868301-1773-1-git-send-email-m.b.lankhorst@gmail.com>
In-Reply-To: <1307868301-1773-1-git-send-email-m.b.lankhorst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>Maarten Lankhorst <m.b.lankhorst@gmail.com>, Peter Jones <pjones@redhat.com>

<snip>

Hi Maarten:
It registered efifb_device but try to unregistered efifb_driver,
so I think you should fix it like this?

Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 drivers/video/efifb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 69c49df..784139a 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -541,7 +541,7 @@ static int __init efifb_init(void)
 	 */
 	ret = platform_driver_probe(&efifb_driver, efifb_probe);
 	if (ret) {
-		platform_device_unregister(&efifb_driver);
+		platform_device_unregister(&efifb_device);
 		return ret;
 	}
 
-- 
1.7.4.1


