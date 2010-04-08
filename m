From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 14/16] Remove cursor restore hack in viafb
Date: Thu,  8 Apr 2010 11:15:44 -0600
Message-ID: <1270746946-12467-15-git-send-email-corbet@lwn.net>
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

From: Deepak Saxena <dsaxena@laptop.org>

Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
---
 drivers/video/via/viafbdev.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 56d5416..684a5c4 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1940,15 +1940,6 @@ static int viafb_resume(struct pci_dev *pdev)
 	viaVidEng->cursor_bg = localVidEng->cursor_bg;
 	viaVidEng->cursor_fg = localVidEng->cursor_fg;
 
-	/*
-	 * Magic register dance to  make cursor reappear.
-	 *
-	 * Currently hardcoded settings need to clean this all
-	 * up later...
-	 */
-	viaVidEng->hi_control = 0xb6000005;
-	viaVidEng->compose   |= 0xc0000000;
-
 	fb_set_suspend(viafbinfo, 0);
 
 fail:
-- 
1.7.0.1
