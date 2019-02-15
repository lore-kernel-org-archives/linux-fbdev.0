From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:59:00 +0000
Subject: [PATCH 3/4] fbdev: atafb: Fix broken frame buffer after kexec
Message-Id: <20190215085901.21479-4-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190215085901.21479-1-geert@linux-m68k.org>
In-Reply-To: <20190215085901.21479-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Schmitz <schmitzmic@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

On Falcon, Atari frame buffer initialization relies on preprogrammed
register values.  These register values are changed to blank the
console.

Hence when using kexec to boot into a new kernel while the console is
blanked, the new kernel cannot determine the current video
configuration, and the Atari frame buffer driver fails to initialize:

    atafb: phys_screen_base 6ce000 screen_len 4096

Fix this by doing a straight-forward conversion of the driver to a
platform device driver, and adding a shutdown handler that unblanks the
display.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index d82007c113e6303c..4db8166d11b30409 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <linux/uaccess.h>
@@ -3072,7 +3073,7 @@ int __init atafb_setup(char *options)
 	return 0;
 }
 
-int __init atafb_init(void)
+static int __init atafb_probe(struct platform_device *pdev)
 {
 	int pad, detected_mode, error;
 	unsigned int defmode = 0;
@@ -3084,9 +3085,6 @@ int __init atafb_init(void)
 	atafb_setup(option);
 	printk("atafb_init: start\n");
 
-	if (!MACH_IS_ATARI)
-		return -ENODEV;
-
 	do {
 #ifdef ATAFB_EXT
 		if (external_addr) {
@@ -3247,4 +3245,32 @@ int __init atafb_init(void)
 	return 0;
 }
 
+static void atafb_shutdown(struct platform_device *pdev)
+{
+	/* Unblank before kexec */
+	if (fbhw->blank)
+		fbhw->blank(0);
+}
+
+static struct platform_driver atafb_driver = {
+	.shutdown	= atafb_shutdown,
+	.driver	= {
+		.name	= "atafb",
+	},
+};
+
+static int __init atafb_init(void)
+{
+	struct platform_device *pdev;
+
+	if (!MACH_IS_ATARI)
+		return -ENODEV;
+
+	pdev = platform_device_register_simple("atafb", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return platform_driver_probe(&atafb_driver, atafb_probe);
+}
+
 device_initcall(atafb_init);
-- 
2.17.1
