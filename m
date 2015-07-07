From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 07 Jul 2015 08:26:35 +0000
Subject: [PATCH 3/5] staging: sm7xxfb: use kernel commandline
Message-Id: <1436256877-10754-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

We were only using the kernel commandline to set the mode if this driver
is builtin, but when it is built as a module we were not having any way
to set the mode. Start using commandline even if it is built as a
module.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 8fb62af..4dc9d5f 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -1660,14 +1660,12 @@ static struct pci_driver smtcfb_driver = {
 
 static int __init sm712fb_init(void)
 {
-#ifndef MODULE
 	char *option = NULL;
 
 	if (fb_get_options("sm712fb", &option))
 		return -ENODEV;
 	if (option && *option)
 		mode_option = option;
-#endif
 	sm7xx_vga_setup(mode_option);
 
 	return pci_register_driver(&smtcfb_driver);
-- 
1.8.1.2

