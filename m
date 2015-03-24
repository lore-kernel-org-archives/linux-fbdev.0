From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 24 Mar 2015 10:52:50 +0000
Subject: [PATCH resend] staging: sm7xxfb: add MODULE_DEVICE_TABLE
Message-Id: <1427194344-4239-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

add MODULE_DEVICE_TABLE to support hot-plugging.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

resending as discussed with Greg K-H

 drivers/staging/sm7xxfb/sm7xxfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index abdb021..5b3e614 100644
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

