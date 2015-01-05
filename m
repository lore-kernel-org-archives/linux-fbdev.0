From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 05 Jan 2015 08:15:16 +0000
Subject: [PATCH] simplefb: Fix build failure on Sparc
Message-Id: <1420445716-13468-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

of_platform_device_create is only defined when CONFIG_OF_ADDRESS is set,
which is normally always the case when CONFIG_OF is defined, except on Sparc,
so explicitly check for CONFIG_OF_ADDRESS rather then for CONFIG_OF.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 92cac80..1085c04 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -402,7 +402,7 @@ static int __init simplefb_init(void)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_OF) && of_chosen) {
+	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
 		for_each_child_of_node(of_chosen, np) {
 			if (of_device_is_compatible(np, "simple-framebuffer"))
 				of_platform_device_create(np, NULL, NULL);
-- 
2.1.0

