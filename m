From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Date: Fri, 17 Apr 2015 09:48:02 +0000
Subject: [PATCH] video/logo: fix use logo after free prevention
Message-Id: <5530D6D2.8080103@gmx.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Manfred Schlaegl <manfred.schlaegl@gmx.at>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

After 92b004d1aa9f367c372511ca0330f58216b25703 the logos disappeared on
Freescale i.MX53 and i.MX6 SoC's (detected on linux-3.12.37).
This happens because the fb_find_logo function is validly called
(initdata still not freed) AFTER newly introduced latecall
fb_logo_late_init.

Instead of stetting a logos_freed flag somewhere in lateinit, this patch
uses system_state=SYSTEM_BOOTING as indication for valid initdata.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/video/logo/logo.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 10fbfd8..ad37561 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -21,21 +21,6 @@ static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
 
-/*
- * Logos are located in the initdata, and will be freed in kernel_init.
- * Use late_init to mark the logos as freed to prevent any further use.
- */
-
-static bool logos_freed;
-
-static int __init fb_logo_late_init(void)
-{
-	logos_freed = true;
-	return 0;
-}
-
-late_initcall(fb_logo_late_init);
-
 /* logo's are marked __initdata. Use __init_refok to tell
  * modpost that it is intended that this function uses data
  * marked __initdata.
@@ -44,7 +29,11 @@ const struct linux_logo * __init_refok fb_find_logo(int depth)
 {
 	const struct linux_logo *logo = NULL;
 
-	if (nologo || logos_freed)
+	/*
+	 * Logos are located in the initdata, and will be freed in kernel_init.
+	 * Use system_state to determine, if initdata is still useable.
+	 */
+	if (nologo || system_state != SYSTEM_BOOTING)
 		return NULL;
 
 	if (depth >= 1) {
-- 
1.7.10.4

