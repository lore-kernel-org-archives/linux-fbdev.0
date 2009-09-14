From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] fbdev: bfin-t350mcqb-fb: fix LCD dimensions
Date: Mon, 14 Sep 2009 13:49:09 -0400
Message-ID: <1252950549-9838-3-git-send-email-vapier@gentoo.org>
References: <1252950549-9838-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755810AbZINRtX@vger.kernel.org>
In-Reply-To: <1252950549-9838-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The height/width framebuffer members need to be set in millimeters so that
software can do proper scaling.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bfin-t350mcqb-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 46cb07f..2549c53 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -487,8 +487,8 @@ static int __devinit bfin_t350mcqb_probe(struct platform_device *pdev)
 
 	fbinfo->var.nonstd = 0;
 	fbinfo->var.activate = FB_ACTIVATE_NOW;
-	fbinfo->var.height = -1;
-	fbinfo->var.width = -1;
+	fbinfo->var.height = 53;
+	fbinfo->var.width = 70;
 	fbinfo->var.accel_flags = 0;
 	fbinfo->var.vmode = FB_VMODE_NONINTERLACED;
 
-- 
1.6.4.2
