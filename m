From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/6] Xilinxfb: add banner output to probe routine when DEBUG	is
 defined
Date: Mon, 01 Oct 2007 09:57:33 -0600
Message-ID: <20071001155733.6114.71740.stgit@trillian.cg.shawcable.net>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751910AbXJAP6f@vger.kernel.org>
In-reply-to: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

From: Grant Likely <grant.likely@secretlab.ca>

Debug support: when DEBUG is defined, output relevant details to the
log about the framebuffer registration.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 4bc67ab..1a5f1e4 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -287,6 +287,11 @@ xilinxfb_drv_probe(struct device *dev)
 		goto failed4;
 	}
 
+	/* Put a banner in the log (for DEBUG) */
+	dev_dbg(dev, "regs: phys=%x, virt=%p\n",
+		drvdata->regs_phys, drvdata->regs);
+	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
+		(void*)drvdata->fb_phys, drvdata->fb_virt, FB_SIZE);
 	return 0;	/* success */
 
 failed4:
