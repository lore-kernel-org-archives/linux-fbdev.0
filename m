From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/16] fix register save count, so it matches the restore count.
Date: Thu,  8 Apr 2010 11:15:42 -0600
Message-ID: <1270746946-12467-13-git-send-email-corbet@lwn.net>
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

From: Paul Fox <pgf@laptop.org>

Signed-off-by: Paul Fox <pgf@laptop.org>
---
 drivers/video/via/viafbdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 88298e1..5a5964f 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1852,7 +1852,7 @@ static int viafb_suspend(struct pci_dev *pdev, pm_message_t state)
 
 		memcpy_fromio(viaparinfo->shared->saved_regs,
 			      viaparinfo->shared->engine_mmio + 0x100,
-			      0xff * sizeof(u32));
+			      0x100 * sizeof(u32));
 
 		fb_set_suspend(viafbinfo, 1);
 
-- 
1.7.0.1
