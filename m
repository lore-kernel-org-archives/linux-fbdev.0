From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 24 Mar 2015 04:50:37 +0000
Subject: [PATCH 2/2] staging: sm7xxfb: add MODULE_DEVICE_TABLE
Message-Id: <1427172609-4318-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

add MODULE_DEVICE_TABLE to support hot-plugging.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 6e9b2aa..15509a6 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -922,6 +922,8 @@ static const struct pci_device_id smtcfb_pci_table[] = {
 	{0,}
 };
 
+MODULE_DEVICE_TABLE(pci, smtcfb_pci_table);
+
 static void smtcfb_pci_remove(struct pci_dev *pdev)
 {
 	struct smtcfb_info *sfb;
-- 
1.8.1.2

