From: Joe Perches <joe@perches.com>
Subject: [PATCH] nvidia.c: Use correct length in strncmp
Date: Mon, 09 Nov 2009 18:08:01 -0800
Message-ID: <1257818881.12852.77.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753627AbZKJCH5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/drivers/video/nvidia/nvidia.c
b/drivers/video/nvidia/nvidia.c
index efe10ff..81e78c9 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1495,7 +1495,7 @@ static int __devinit nvidiafb_setup(char *options)
 			flatpanel = 1;
 		} else if (!strncmp(this_opt, "hwcur", 5)) {
 			hwcur = 1;
-		} else if (!strncmp(this_opt, "noaccel", 6)) {
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
 		} else if (!strncmp(this_opt, "noscale", 7)) {
 			noscale = 1;
