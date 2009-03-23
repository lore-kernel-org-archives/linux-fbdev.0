From: Sergey Senozhatsky <sergey.senozhatsky@mail.by>
Subject: [PATCH 2.6.29-rc8] fb: nvidiafb recognizes geforcego 7300 chip as
 mobile
Date: Tue, 24 Mar 2009 00:01:10 +0200
Message-ID: <49C806A6.2000007@mail.by>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758459AbZCWW6v@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky@mail.by>

nvidiafb recognizes geforcego 7300 chip as mobile

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@mail.by>
---
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index d9627b5..135ae18 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -362,6 +362,7 @@ int NVCommonSetup(struct fb_info *info)
 	case 0x0186:
 	case 0x0187:
 	case 0x018D:
+	case 0x01D7:
 	case 0x0228:
 	case 0x0286:
 	case 0x028C:
