From: Jun Nie <niej0001@gmail.com>
Date: Tue, 10 Nov 2009 08:12:19 +0000
Subject: [PATCH 4/8] pxa: delete redundant vsync/hsync revert flag
Message-Id: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From f0ba46eda943db08e60bcfe536f876f09165a64c Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 15:11:36 +0800
Subject: [PATCH] pxa: delete redundant  vsync/hsync revert flag
      var.sync can cover its function

Signed-off-by: Jun Nie <njun@marvell.com>
---
 include/video/pxa168fb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 024767c..efbe469 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -142,8 +142,6 @@ struct pxa168fb_mach_info {
 	unsigned	invert_composite_blank:1;
 	unsigned	invert_pix_val_ena:1;
 	unsigned	invert_pixclock:1;
-	unsigned	invert_vsync:1;
-	unsigned	invert_hsync:1;
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
-- 
1.5.4.3
