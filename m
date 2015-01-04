From: Mathias Krause <minipli@googlemail.com>
Date: Sun, 04 Jan 2015 14:04:34 +0000
Subject: [PATCH] atyfb: mark DMI system id table as __initconst
Message-Id: <1420380274-8015-1-git-send-email-minipli@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We can mark the DMI system id table as __initconst by using a helper
variable that'll tell us if we need to unregister the reboot notifier in
atyfb_exit() instead of matching the DMI system id again.

This frees up ~680 bytes of runtime memory, the DMI table occupies.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/video/fbdev/aty/atyfb_base.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 37ec09b3fffd..8789e487b96e 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3948,7 +3948,7 @@ static struct notifier_block atyfb_reboot_notifier = {
 	.notifier_call = atyfb_reboot_notify,
 };
 
-static const struct dmi_system_id atyfb_reboot_ids[] = {
+static const struct dmi_system_id atyfb_reboot_ids[] __initconst = {
 	{
 		.ident = "HP OmniBook 500",
 		.matches = {
@@ -3960,6 +3960,7 @@ static const struct dmi_system_id atyfb_reboot_ids[] = {
 
 	{ }
 };
+static bool registered_notifier = false;
 
 static int __init atyfb_init(void)
 {
@@ -3982,15 +3983,17 @@ static int __init atyfb_init(void)
 	if (err1 && err2)
 		return -ENODEV;
 
-	if (dmi_check_system(atyfb_reboot_ids))
+	if (dmi_check_system(atyfb_reboot_ids)) {
 		register_reboot_notifier(&atyfb_reboot_notifier);
+		registered_notifier = true;
+	}
 
 	return 0;
 }
 
 static void __exit atyfb_exit(void)
 {
-	if (dmi_check_system(atyfb_reboot_ids))
+	if (registered_notifier)
 		unregister_reboot_notifier(&atyfb_reboot_notifier);
 
 #ifdef CONFIG_PCI
-- 
1.7.10.4

