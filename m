From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 24 Mar 2015 04:50:21 +0000
Subject: [PATCH 1/2] staging: sm7xxfb: start using module parameters
Message-Id: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

add module parameters so that we can configure X and Y resolutions
and bpp when using this driver as a module.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index abdb021..6e9b2aa 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -1033,6 +1033,24 @@ static int __init sm712fb_init(void)
 
 module_init(sm712fb_init);
 
+module_param(mode_option, charp, S_IRUGO);
+
+MODULE_PARM_DESC(mode_option, "\n\t\tOptions:\n"
+		 "\t\t0x301 = 640x480-8\n"
+		 "\t\t0x303 = 800x600-8\n"
+		 "\t\t0x305 = 1024x768-8\n"
+		 "\t\t0x307 = 1280x1024-8\n"
+		 "\t\t0x311 = 640x480-16\n"
+		 "\t\t0x314 = 800x600-16\n"
+		 "\t\t0x317 = 1024x768-16\n"
+		 "\t\t0x31A = 1280x1024-16\n"
+		 "\t\t0x312 = 640x480-24\n"
+		 "\t\t0x315 = 800x600-24\n"
+		 "\t\t0x318 = 1024x768-24\n"
+		 "\t\t0x31B = 1280x1024-24\n"
+		 "\t\tUsual example:\n"
+		 "\t\tinsmod ./sm7xxfb.ko mode_option=\"0x301\"\n");
+
 static void __exit sm712fb_exit(void)
 {
 	pci_unregister_driver(&smtcfb_driver);
-- 
1.8.1.2

