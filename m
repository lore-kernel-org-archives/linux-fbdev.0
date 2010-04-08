From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 16/16] viafb: Only suspend/resume on VX855
Date: Thu,  8 Apr 2010 11:15:46 -0600
Message-ID: <1270746946-12467-17-git-send-email-corbet@lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

The code is only known to work there, and is strongly suspected to not work
on other chipsets.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/viafbdev.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index f834440..2e70c79 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1916,6 +1916,12 @@ static int viafb_suspend(struct pci_dev *pdev, pm_message_t state)
 	int i;
 	void __iomem *iomem = viaparinfo->shared->engine_mmio;
 
+/*
+ * This code is currently only known to work on VX855
+ */
+	if (viaparinfo->shared->chip_info.gfx_chip_name != UNICHROME_VX855)
+		return -ENOTSUPP;
+
 	if (state.event == PM_EVENT_SUSPEND) {
 		acquire_console_sem();
 
@@ -1940,6 +1946,12 @@ static int viafb_resume(struct pci_dev *pdev)
 	int i;
 	void __iomem *iomem = viaparinfo->shared->engine_mmio;
 
+/*
+ * This code is currently only known to work on VX855
+ */
+	if (viaparinfo->shared->chip_info.gfx_chip_name != UNICHROME_VX855)
+		return -ENOTSUPP;
+
 	acquire_console_sem();
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-- 
1.7.0.1
