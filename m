From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 17:52:09 +0000
Subject: [PATCH 1/3] staging: sm7xxfb: use module init and exit
Message-Id: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

use module_init() and module_exit() instead of module_pci_driver
and at the same time make way for use of kernel boot parameters.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index ebd9536..17b3917 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -113,6 +113,8 @@ static struct vesa_mode vesa_mode_table[] = {
 
 static struct screen_info smtc_scr_info;
 
+static char *mode_option;
+
 /* process command line options, get vga parameter */
 static int __init sm7xx_vga_setup(char *options)
 {
@@ -1017,7 +1019,29 @@ static struct pci_driver smtcfb_driver = {
 	.driver.pm  = SM7XX_PM_OPS,
 };
 
-module_pci_driver(smtcfb_driver);
+static int __init sm712fb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("sm712fb", &option))
+		return -ENODEV;
+	if (option && *option)
+		mode_option = option;
+#endif
+	sm7xx_vga_setup(mode_option);
+
+	return pci_register_driver(&smtcfb_driver);
+}
+
+module_init(sm712fb_init);
+
+static void __exit sm712fb_exit(void)
+{
+	pci_unregister_driver(&smtcfb_driver);
+}
+
+module_exit(sm712fb_exit);
 
 MODULE_AUTHOR("Siliconmotion ");
 MODULE_DESCRIPTION("Framebuffer driver for SMI Graphic Cards");
-- 
1.9.1

