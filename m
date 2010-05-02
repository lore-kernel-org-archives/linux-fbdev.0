From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 02 May 2010 15:17:32 +0000
Subject: [PATCH 2/4] viafb: restore display on resume
Message-Id: <1272813454-3229-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: restore display on resume

This patch makes viafb restore the display on resume by calling
viafb_set_par. Resumeing has still its issues:
- will probably freeze most machines (for me on VX800 reliable on the
  second resume)
- under some configurations the screen appears on the wrong output
  device (reason unknown)

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 1b435b3..b4baed6 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1777,6 +1777,9 @@ int viafb_resume(struct pci_dev *pdev)
 		    viaparinfo->shared->saved_regs,
 		    0x100 * sizeof(u32));
 
+	viafb_set_par(viafbinfo);
+	if (viafb_dual_fb)
+		viafb_set_par(viafbinfo1);
 	fb_set_suspend(viafbinfo, 0);
 
 fail:
-- 
1.6.3.2

