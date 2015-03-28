From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 28 Mar 2015 09:15:41 +0000
Subject: [PATCH 2/2] staging: sm7xxfb: disable pci device
Message-Id: <1427533421-9751-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427533421-9751-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1427533421-9751-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

disable the pci device when the module exits.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 149286e..77f51a0 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -943,6 +943,7 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
 	unregister_framebuffer(&sfb->fb);
 	smtc_free_fb_info(sfb);
 	pci_release_region(pdev, 0);
+	pci_disable_device(pdev);
 }
 
 #ifdef CONFIG_PM
-- 
1.8.1.2

