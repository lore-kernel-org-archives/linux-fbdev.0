From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 24 Sep 2010 04:51:09 +0000
Subject: [PATCH 2/4] viafb: restore display on resume
Message-Id: <e16aa3895c06ec782df51f030dda61bc2ba322cc.1285303223.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1285303222.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1285303222.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Jonathan Corbet <corbet@lwn.net>

This patch makes viafb restore the display on resume by calling
viafb_set_par. Resumeing has still its issues:
- will probably freeze most machines (for me on VX800 reliable on the
  second resume)
- under some configurations the screen appears on the wrong output
  device (reason unknown)

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/viafbdev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index f2b68cc..5b23293 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1522,6 +1522,9 @@ int viafb_resume(struct pci_dev *pdev)
 		    viaparinfo->shared->saved_regs,
 		    0x100 * sizeof(u32));
 
+	viafb_set_par(viafbinfo);
+	if (viafb_dual_fb)
+		viafb_set_par(viafbinfo1);
 	fb_set_suspend(viafbinfo, 0);
 
 fail:
-- 
1.6.3.2

